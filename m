Return-Path: <linux-kernel+bounces-226441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D859913E64
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DDC11C20B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013DD1849F4;
	Sun, 23 Jun 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NJlWa/Bz"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783718307B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719176739; cv=none; b=A/B5gspja39W/aed3+4JkPVO0ReV06Tciu8vX+vgY/Tsj+gp980W4bs9FOe8/IhAD8w/z4ITKTuyktCu4fJk2RiSW7YsIbIppzr6vSPRGWpfkngNZlhKHF1jQlKz//AAusVNqrM4zzaOAdCvf8oLuqqKCZyPm7qCKE4xTQGF2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719176739; c=relaxed/simple;
	bh=Al+291Xyycs/DdCbGs87MJcKI4GoGP8NCQsNKuLFZFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx23EZvSvx4obECKHH5pYEwey/QHGHL1tx0VA+9Wilvpjww4sYBXiaF31hzV7UBy5h0vF+MkWuzVYwU8E97JxeIlE7cwltrTTv5t8s6ZWjyyfNg73+hpYLikTQ3gRkcjAElukk3dh+p7Tf+QQC5d5BifQ2NfjBmJgS8k02qaHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NJlWa/Bz; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+249018ea545364f78d04@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719176735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Al+291Xyycs/DdCbGs87MJcKI4GoGP8NCQsNKuLFZFI=;
	b=NJlWa/BzVsaUvn75phebeNUUycwmMHvi0pxP4tJACVeYfB5JrJebk5rrJzlvZ44QOopQra
	srUUiulj3TIwRkL7Gutds6ShSdkdFzLeGnAeaoQ3BUStJTVbCATZt2OBkA4tbXmEIwhEQc
	YBwZ1f8JaFiljH4UgRdlMxLCcC37G8E=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Sun, 23 Jun 2024 17:05:31 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+249018ea545364f78d04@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in
 bch2_sb_dev_has_data
Message-ID: <xilto7vl6zouisudamqjaza5z3ziyi5idype64nuuewpxq4gds@3aa575tsq7dn>
References: <000000000000ebf2e0061866b102@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ebf2e0061866b102@google.com>
X-Migadu-Flow: FLOW_OUT

#syz fix: bcachefs: Fix shift overflows in replicas.c

