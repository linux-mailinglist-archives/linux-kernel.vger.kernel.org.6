Return-Path: <linux-kernel+bounces-312717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C4969A44
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85305B22948
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A51B983B;
	Tue,  3 Sep 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXroNNRG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3C31A0BEC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359666; cv=none; b=j/vI0L1r3TdnCfm/Nn0AB8p7DlyXKfb73bqJK0PSZdA9ht8xqGiEThWkgo2U+Et33Qxg8jiAIxWxzIbMjLAwtgAltFxtHasOnr6/jyzHgRzEcaH8DtNXHZ4oijKL7mMSmfjUHpXyQSXxsAJPH6JBvOl/UXOgtRCJsQfX2O+2YF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359666; c=relaxed/simple;
	bh=UfnS01Q7flgZRu55Fz0q4m6eu4eoSwOkx1BtOnTXySw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m83O0d9oCCoRd6T83kB4nvhrz1QR7Q4NxVEdPaSWUiEC1OSwyZY4UgupEdN//5kJYQukyvCIPCEV3/uGg7VkGVQYLcpvMHqibfbfgAyIks/ScwPKdLBlWc3dfN9viPtRPPRW0yoTYxoar+ZRTzg+wBrjecN7VBCn6TSivVYc9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXroNNRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2222C4CEC4;
	Tue,  3 Sep 2024 10:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725359665;
	bh=UfnS01Q7flgZRu55Fz0q4m6eu4eoSwOkx1BtOnTXySw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXroNNRGDfuSyumfhtDVZKh3TNm0bm/069G6sE0/dem+uJuR1p6PNsSb3Foqb4JKY
	 UAtvBtfAlrBQQV85/eRhe4BmGGvgg+eQCmk22Phg6UyC4QN35dLL5gtT5kc+cHv9VM
	 0MeySPr2+e3/QTF0VHnDJy2UkQY/ogL1BwyGbKWg=
Date: Tue, 3 Sep 2024 12:02:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, cmllamas@google.com,
	surenb@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] binder: modify the comment for binder_proc_unlock
Message-ID: <2024090338-crimp-mountable-54d7@gregkh>
References: <20240902033754.2708-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902033754.2708-1-bajing@cmss.chinamobile.com>

On Mon, Sep 02, 2024 at 11:37:54AM +0800, Ba Jing wrote:
> Modify the comment for binder_proc_unlock() to clearly indicate which spinlock it releases and to better match the acquire comment block in binder_proc_lock().
> 
> Notes:
> v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/
> 
> v2: Reword commit log per suggestions from cmllamas@
> https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/
> 
> v3: Wrap commit message. Add version history.
> https://lore.kernel.org/all/20240902025720.2334-1-bajing@cmss.chinamobile.com/
> 
> v4: Modify the commit information.

Again, all of these "what changed in what version" needs to go below the
--- line.

Also, please wrap your changelog text at 72 columns, like your editor
asked you to :)

thanks,

greg k-h

