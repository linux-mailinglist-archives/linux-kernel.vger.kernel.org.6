Return-Path: <linux-kernel+bounces-261468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F193B7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1B1C241BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339F116C6AC;
	Wed, 24 Jul 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OBk+LTvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775E615F318
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721850652; cv=none; b=gjnLBdzHk2RPpPo+EiTrXox2vZV1NraZYBV8ghjMqLOTXeqpIBHzLjidnBLCx6GnFYqArzP7eiS1S08ri0lMUlkNaxYk1/4O00K8yif/UMfl+pBEu90yYmp2IhYzGq+WzUdNStD5Dx+nCqOZ/jKtzfH3Sy07npyA+t2uYR5nzGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721850652; c=relaxed/simple;
	bh=Vo2ZYK/9qQIt8EuqzUt2ngCqfEufrqkFAQYYafdhqX4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bnb6wA8fNrwNKVJ4D9IReUcpmQfTDShD1A0ReDvwE+eOqWwo8hicwzeQIJCuHeHINMqX6MPsQLjErAPcpNbwAjNKy+vG4TairBok3hzT+OlDt5Rw26PAOODiOPj/5gH6+aeYwlL1TM6QFMJvoD5vHpRPY/ZsMPqkykw/k3rlPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OBk+LTvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A5C32781;
	Wed, 24 Jul 2024 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721850652;
	bh=Vo2ZYK/9qQIt8EuqzUt2ngCqfEufrqkFAQYYafdhqX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OBk+LTvzmfv1bKDgSJrw6nvV/TOE0NgMBcQtQsgj0bM0PzquiGfFdYslo7nTY2VDW
	 0S/XyaQhyevO+t36G7/a2Umwu5NdQ//A60kWvaE+4n0jTzijhQrv+0OuX7CnbbHqNk
	 NeSErWXXHil2SwJp75zgYsmJ+qCD3dmrvfSSaUas=
Date: Wed, 24 Jul 2024 12:50:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/cma: export total and free number of pages for CMA
 areas
Message-Id: <20240724125051.a601784c1325c21cc109bba0@linux-foundation.org>
In-Reply-To: <CAPTztWbF+VLO6g=7VKk-tYHdtZ781Hbj5ucW6i8Gf9TJiiebWg@mail.gmail.com>
References: <20240709163053.2514760-1-fvdl@google.com>
	<CAPTztWbF+VLO6g=7VKk-tYHdtZ781Hbj5ucW6i8Gf9TJiiebWg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 09:24:58 -0700 Frank van der Linden <fvdl@google.com> wrote:

> I realize that this isn't the most exciting patch, but.. any comments? :)

It arrived quite late in the -rc cycle.

I suggest a resend, and add some Cc:s for likely reviewers.

