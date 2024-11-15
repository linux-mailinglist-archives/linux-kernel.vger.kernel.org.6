Return-Path: <linux-kernel+bounces-410106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CC9C9690
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903071F22642
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466D80B;
	Fri, 15 Nov 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="x1VnqgoY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4E936C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731629646; cv=none; b=UvWF6SpOeEYbEikHPuNCal51qX/jGsCUIo+3MawAICjutnNL9rnlPPCyMaBJt6yAxawHf2WVTvykaWCbsqzstugdSaZho1l/41cLm19qpkW4sPXLsYGiT0Xipq3SNerEhxR55nEvXGvar54rPiQtTHEyBjNb0HU0JwZIcUx6lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731629646; c=relaxed/simple;
	bh=MLf55gCtLwZQrttnHZpUxgNRnkiqQzPK/JsG4taQzY0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oPb53Znd0W9A6nu9MMgkrLMJFZfNqaY92p4rwqfgbQBg9pWDdc2pbeviODXD3aMk2FDAtJ92wWqoVl1qRNeqWjSWTN2onLZSxsRMQeUVII52zjQsXcYl0+bwY0RmVkpqF9q0/d+1twqqOhI9zh86U7+6g8xj2AW3ylCrJKlMWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=x1VnqgoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A685C4CECD;
	Fri, 15 Nov 2024 00:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731629645;
	bh=MLf55gCtLwZQrttnHZpUxgNRnkiqQzPK/JsG4taQzY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=x1VnqgoYT+UYj8J0qhjI6/GE2LNAxNhcQ9izrgPsnGGiEBe8lQqSqtypKzxgVIc1e
	 7r0GLuMT9QGdX5bQ9sfFvGmO6j4FhpLomJJ5GEEgVabFPe8VQ9yCAGClyav0q41+vk
	 iCScM6rW1QJKCVHb0ecYbHH4+TuAXmWqXcp1Z4rM=
Date: Thu, 14 Nov 2024 16:14:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: yongli-oc <yongli-oc@zhaoxin.com>
Cc: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
 <cobechen@zhaoxin.com>, <louisqi@zhaoxin.com>, <jiangbowang@zhaoxin.com>
Subject: Re: [PATCH] Support lockref reference count if enable LOCK_STAT
Message-Id: <20241114161400.72259c36cca41c0c2da6d971@linux-foundation.org>
In-Reply-To: <20241113085703.148839-1-yongli-oc@zhaoxin.com>
References: <20241113085703.148839-1-yongli-oc@zhaoxin.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:57:03 +0800 yongli-oc <yongli-oc@zhaoxin.com> wrote:

> Swap the positions of lock and count to support CMPXCHG_LOCKREF
> if SPINLOCK_SIZE > 4 when enable LOCK_STAT. The reference count
> can always be used regardless of the spinlock_t size.

Please fully describe the problem we're solving here?  And what are the
runtime effects of this change?

