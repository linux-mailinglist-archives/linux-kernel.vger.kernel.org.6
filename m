Return-Path: <linux-kernel+bounces-396806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B739BD267
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46351C224A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA391D89E5;
	Tue,  5 Nov 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b="Y97+dNC0"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA8154BEE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824457; cv=none; b=XwwoT4W3tVJztzQdck1LHl1FMh7b3UXUbYx04DKx8TGY3gG3GZx+koljxzll56DFwsm8wSMGRPwAo6QvhIbBI+2PfrheuccmoZIZ25wI5EkOZdN/eq5jTnIzdj0nK070EgkJHJrc5ya6YW2MBV7G18L5jDnyXSmkfIFQi/d3P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824457; c=relaxed/simple;
	bh=82B62g3W1VnLjaYhP74fO+YgMHdnY7E8gTBxNO5t11k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vlmh5izOLRRDR9EZi9Km/t95Qiz/vOPBsrcnCTAfjQgC+JiAI/vdK+LkeFfeT7VwGfLH3FG71MJvcTc1pwc2x170t2P5gA5rGUHoGVlyDcax7WyBBHqnJgyUCrkS9Wap1FZlaxpD6uYfmujxDti8cp2t+lx/9vD1o704E2yMhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=falaichte@mailfence.com header.b=Y97+dNC0; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Received: from fidget.co-bxl (fidget.co-bxl [10.2.0.33])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 0F0D1367F;
	Tue,  5 Nov 2024 17:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730824453;
	s=20240605-akrp; d=mailfence.com; i=falaichte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e4YPL8tXDDW31AjcYTkXuP4XF4+WI2f/fwYfwPivIB4=;
	b=Y97+dNC015FVa8Q00qKj96V5Qse1S4eMLDONu1unWgl+8L/EnJIIQrX/oLryhTH+
	v7uyQBAPnTf+ejPwDGNyIulQbfc2g3wAb5z6JXZKhp4hmJJpqPC6+mvaw0r99M5SfbY
	wc3q4kQC+zhv0GXQqkR22ckt3Dx2ydhu3VbmcWC5THcFFaZAAV2ij0y5MXgxy7by7zJ
	gy2+t/4FIHctbyZRqasGwf8Ch43dfOwbT4KxSQryu241Pz1WsN5Yh+625j9NENcnzhK
	sqcMt7h258l3MoVLkIly9TfG1pNJGxYD9UAM+4Pmw7Z49VB0mhvfadkra8BPG57Loso
	qhVKLClctg==
Date: Tue, 5 Nov 2024 17:34:11 +0100 (CET)
From: =?utf-8?Q?Dylan_=E2=80=8E_=E2=80=8E?= <falaichte@mailfence.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Message-ID: <1644432842.140359.1730824451296@fidget.co-bxl>
In-Reply-To: <20241105160622.GV1350452@ZenIV>
References: <1116521637.127547.1730818127738@fidget.co-bxl> <1552791356.130304.1730819601359@fidget.co-bxl> <237077017.130501.1730819723674@fidget.co-bxl> <20241105160622.GV1350452@ZenIV>
Subject: Re: Russians in the Kernel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:490142097

> For another,
any proxy set up to bypass the sanctions that really exist (i.e.
based on employment by sanctioned companies) would fall under the
same sanctions.

You could make the argument that sanctions as per the laws of the United States is itself unconstitutional as it impedes people's right to freedom of assembly. Even then, there is still the point that the Linux kernel and similar open source projects are transnational communities and by prohibiting access to participation you aren't respecting the spirit of free and open source software. Where anyone may participate regardless of their walk of life. I can understand not wanting to incur the wrath of the American government and that it is better to comply in some cases than make a stand as has been the case with Nintendo and emulation. I just simply don't like the amount of governmental overreach with that particular executive order and believe that it should be undermined wherever legally possible. 

Though I'll understand if the idea does end up getting anywhere. I just thought that it was worth sharing nonetheless.

> For another, you really don't want to set anything with even
the slightest whiff of "that's how to hide patch origin and/or
evade review" - that's an open invitation to any organization
that wants to feed something underhanded into the kernel.
Won't be a healthy place to hang around, to put it very mildly.

The difference is that it would all be above board with the intermediary acting as a buffer between those targeted by sanctions and the work they've done. It's all open source anyway, so there's nothing that can be done if their source code was forked and then used upstream in a patch series.

-- 
Sent with https://mailfence.com  
Secure and private email

