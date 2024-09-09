Return-Path: <linux-kernel+bounces-321448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1699971A80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C941F244C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC631BA87E;
	Mon,  9 Sep 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b="xDp38snK"
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26391B790E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887459; cv=none; b=odGDNDl8IfV+q7EafwT7k2hmP6x4Tc01/bp7b1HxxTBQxlf7Y6OXTrVIM5qZmlxw/f2OZfbZMyrnYJfu5/oxEE1WL/J6iS5KoRK3OeQ21WnVi/IMiPaBh2jWb4/4ofKBxqNW7yg/0RbVU1mZY6lg3Z1NBK7Y8BriX+rMp2jqGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887459; c=relaxed/simple;
	bh=x1Utp4hVLNjK7I0dMVZhgnV3slomHCu9rvIN2emthEs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wxt7TwNZshrOtBXHL1ATaCdCXH2X9+3zFDoIYWlAE74CDfo9iAjqiTikISPxp9JV4BskhyGc1k9GYF0atE6XdL2ogmTwcghVzWo+JZnx/OwXcJ2vG8nrFw6j2kEVV718qwgfgcHUyteKNmyGXHfytCKRbQcs4+bLLY/5de5TvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus; spf=pass smtp.mailfrom=bens.haus; dkim=pass (2048-bit key) header.d=bens.haus header.i=@bens.haus header.b=xDp38snK; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bens.haus
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bens.haus
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id D21771F11B51;
	Mon,  9 Sep 2024 15:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725886835;
	s=s1; d=bens.haus;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=x1Utp4hVLNjK7I0dMVZhgnV3slomHCu9rvIN2emthEs=;
	b=xDp38snKZra6MkMbhLMm3ofTuCHaO7laP208U5qHEc9e4kJYa5qa187Q1yvNLKXj
	dcTcdLSdEE3uGR6K3lHSnBwsOzBmoMNaudb5+h33qKnidndDoOZ7w0b4ce6TeWiIn6K
	5wrxRcy0Op1p5vTqeuaPY1YfzQWMGUZRT4R0//e3pI8IrW1bpIhwUeBWRBgJIWgKBxY
	AvlDWy2nzTmxL2SSQwxY0/Sef/yfW8Mfu8BDOuGDRwHjWg9IPDn0z6hQ+bH1vr2tfaJ
	VmxPB0EMohkH38/JKQVa4M/y0wuiZMVYGkl7hme9/uLpgNnx0ne0Ggeqhh5crl9C6uf
	BnJYnF6ocw==
Date: Mon, 9 Sep 2024 15:00:35 +0200 (CEST)
From: Ben Schneider <ben@bens.haus>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Message-ID: <O6LrmTs--R-9@bens.haus>
In-Reply-To: <87ed7tlnxj.fsf@BLaptop.bootlin.com>
References: <20240603012804.122215-1-ben@bens.haus> <20240603012804.122215-2-ben@bens.haus> <20240605194422.klxtxgyljrrllkzy@pali> <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch> <O1XjBTq--3-9@bens.haus> <87ed7tlnxj.fsf@BLaptop.bootlin.com>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jul 16, 2024, 01:51 by gregory.clement@bootlin.com:

> You received two "reviewed-by" approvals, and Marek Beh=C3=BAn, who wrote=
 the
> patch removing the 1.2GHz limitation, did not object. Therefore, from my
> point of view, there is no problem merging your change.
> Acked-by: Gregory CLEMENT <> gregory.clement@bootlin.com> >
>

Hi all, please let me know if there is anything else needed from me before =
this can be merged. The two devices I have continue to be stable while usin=
g the ondemand scaling policy.

Thanks!

Ben

