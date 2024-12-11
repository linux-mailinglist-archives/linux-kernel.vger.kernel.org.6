Return-Path: <linux-kernel+bounces-441423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F24C9ECE20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED77C28307A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF835239BBB;
	Wed, 11 Dec 2024 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Z6SyTGKq"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CD723692A;
	Wed, 11 Dec 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926145; cv=none; b=fbMR+MBSv4kWTV814Bo8E2vbD0xJwOxKYdAhFeLL9A7WvqPE80jD148sYDdrXEtJBhiKVoEe6e6bt/aD+E5i4YP4iUyTMxqQ9hH2CgS6tQ8J15XQHfFrw88Bog2nEX54kpE/ePX1ELDIOPKhfDDOYPG8QJighiGDEaoXjZXTHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926145; c=relaxed/simple;
	bh=UwZCp54eb/+4kEFaokpoh9DVzhZfjWZQTTCKH1CwyxQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk/T+brYrP2UU/4x5vqN3nHGLkkQWLTsJX1qHDxW2qHaB0VHKOn7KdMXbAt39w9TCcQGoXXZFWp4En+LEhQ9Ty/deB2YDwFWr3ZdSxBoUD2DgocOE+PL8uzIHrCUIKR4N7SkMfHd+oGsmilx/YTLYilIk9WYOYG42w3ljEJkPMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Z6SyTGKq; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733925830; bh=GV/PffgiRhk7TTiNDAMw/6C+sGFhBffZzyUrbe1OAJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z6SyTGKqaOcfCkBX1A8P5Ty/Z+hqs+8t6FtxACa95s9V9yguAbugpdI9By94HuTnq
	 DmlgjV3InKPKkDXi0ehCAPHjQt/TmZf0604BRdqC5opO6SGpEilPS1kl0DrOdza5QW
	 pSU///jI1WKyl8q+st7UGlMo0Dv/xRZU25CQEX3o=
Received: from jckeep-Lenovo-XiaoXinAir-14IIL-2020 ([124.240.55.41])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id E6A1C4F3; Wed, 11 Dec 2024 21:57:42 +0800
X-QQ-mid: xmsmtpt1733925462t7if6hf4c
Message-ID: <tencent_C3D31BDA67AD3F485B2E4D3498E930CD9F09@qq.com>
X-QQ-XMAILINFO: M1JY6XCfJolWm27/3V1TyRgFW0HHQOl9GdLTb8+8plyiqbGBKIIUdNXwX5J2bO
	 bVxr+nvVjYbwh+76V2pfUU+qZ8sNfxXb3NW+osft6NjorCaVsTnh0I8CkYh44noRqXZLoe0+l+Iv
	 ihou4/J7VvLIEGNLgEfcgv/10KnljCcSC3InF+o8XPjO7dBEmzT6JsuNer/89R8IdSaVb4DokQFo
	 wYQTVRMAibeBheAjk+OMlG9GPPB90CtWdclMze9WMlvBmFx18DqErBMEdMAMl6C1clu9heunZjZC
	 R6brjfmX0W/Mw/k0jExStdDnLH3eEJMSzia0ZhAAyS6uCrfMHR8cYh8vZxiyPo4MdameAfnQxso9
	 eRBkB5kx0PoKxwHxXUC71tfGfRTcT89DSCvI70BccQfXW0OQyYwf+j4PvTviNYIm8dlgfxYd+vio
	 kkfxkJmcutBDhFkShBVjnephJ7hBDNFvOmlLOYQyYA6O3UgLDLDbuzv8J0rKgIwKBu0ZYO+qDeQ8
	 qOthiqxWEV0FvixXBPfkANRyxbV2FuvangimrgQ9fauYKoKY6gr31C1BB8uWrs1f/rjhZ/NXamkQ
	 Hn90hs9BlCzBq9SqLcJ2JTJ6muriwFMkWKRxlFef+R5B5VoRri2/juLVOjr91FCxLoLLICD1CGeS
	 s4IDl0GRVTKnR6UnlCNRi8qvmkii7c/vYLQIRoe1WlQFAG6MOo6fu3L+jsquQ0UKZZMl7xqCNRkJ
	 QadjQbnDMbURiyvEpGELbWdIRnNzAxrWXsMgaAy/Uf+1kyniiN7H+nzaN60abJcAcWizYtxF2g6o
	 psthqMcadsh0fiCI+Mrd6JWXaArGhTfFDm4GVOH2ZGX3v31G0ra1XNuswfoKCrEF/1RQPFrJHNe3
	 9+vfwB2wQOCrR4WyhteNVrPgir4CfGQPtyTe6l/UzxgztqJwH6j4+fsgHNSAaxJZ3GeQwtUcqB7W
	 q5hYgBeoDg7BsJGBPL7AbQhDYKqK5EaX8XSNRSX+Y=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Date: Wed, 11 Dec 2024 21:57:42 +0800
From: Guangbo Cui <2407018371@qq.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Add UIO (Userspace I/O) device rust abstraction
X-OQ-MSGID: <Z1maVqm36mCGO8Sl@jckeep-Lenovo-XiaoXinAir-14IIL-2020>
References: <tencent_6FBA3773CF74B276166B63D292CB2E8D3D07@qq.com>
 <2024121150-stretch-password-2179@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024121150-stretch-password-2179@gregkh>

> Very cool!  But can we also see this with a "real" UIO driver as well?

Sure, I will look for a suitable UIO driver to start with. I’ve been quite
busy recently and might not have enough time to dedicate to it, but I will
continue working on it.

> Heck, even a conversion of something "simple" like the uio_dfl.c or
> uio_cif.c would be nice to see (you have to do this on top of the
> platform or pci rust bindings, see the list for the most recent round of
> them).  Seeing how this will be used is kind of key to ensure that we
> know the bindings work properly.

Yes, this patch is on the top of the latest platform rust bindings. 

Best regards,
Guangbo Cui


