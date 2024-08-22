Return-Path: <linux-kernel+bounces-296833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0795AF97
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52556282E42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9342D1537BF;
	Thu, 22 Aug 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShSNfZjx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE6502BE;
	Thu, 22 Aug 2024 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312880; cv=none; b=dmFuxZPfT4QfjZRVMAa/EgCk2CVCHiat2RH1sSvfM22IIEzfL5aFI4/WYNc6ZUp0Ys90iohZYgoBASz0spLk8YmAW1CKMve3+st/yHtUb/ttaOcidzIdv6nG/qsVZziDPWA+uSrX7u8qwYmw519GS8zyQhHO+kCujloHTXjEtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312880; c=relaxed/simple;
	bh=Xmhmp5O4S40x3xcJeqSVTAgrSVTbXmq2bDuYDOcB2Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhDX8OBleW7ojuVDBVP+fvxVed4/g9x9qyWr77jlLogbDVzgr0NHPN/UAaeJdUTWGlDP4W+3+NoT88f5uHvwkT+5ca1vPIWUKZf9c4nqE9a5cO5d+NpCxiaESG9zAW1VNIpJwxzd9rOx5VEq+xDQCHXA37DsFJVv+9cu+vymTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShSNfZjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04409C4AF09;
	Thu, 22 Aug 2024 07:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724312880;
	bh=Xmhmp5O4S40x3xcJeqSVTAgrSVTbXmq2bDuYDOcB2Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShSNfZjxTulDnumzw7YOQens/mIzuS6ANdTuIl3DEdIf/eYMPGbNPyf3iC8CN8Sol
	 AAgiO11LK6I9GSCgVgjlZKdOiC4b/rMcWIYq7QGf+GOEM6eYlV6nzrsvXZv6/G7OOX
	 iU8v/fd0W1yXevLhWsorZVsrtHj+lPZJ8pU3C0Bw=
Date: Thu, 22 Aug 2024 15:47:57 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: soumya.negi97@gmail.com, piroyangg@gmail.com,
	andi.shyti@linux.intel.com, alexondunkan@gmail.com,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] driver:staging:vme:Remove NULL check of list_entry()
Message-ID: <2024082234-nest-diabetes-f9a0@gregkh>
References: <20240822025736.1208339-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822025736.1208339-1-liyuesong@vivo.com>

On Thu, Aug 22, 2024 at 10:57:36AM +0800, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.

Oh, nice catch!  I bet there are lots of other places this happens in
the tree as well.


