Return-Path: <linux-kernel+bounces-200194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698A78FACA4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5541F21D02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA81422AF;
	Tue,  4 Jun 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0anHRPw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801091420D1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487696; cv=none; b=rV7V09eCfyuqgxXWvRSYof56Dgx559VtfxcnLOAFZkbFSCUSOAfqoxbh14MAEysnhQWOkLI93BdK+4SWZ6sicnpgvDwjsx/QTdUt6fgYs9WpBOEZDGlc2rIR/v7eDmDdSWgJ5DCNjpY53emGWWLa740QjxaZRUsMGuG+p7kd4HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487696; c=relaxed/simple;
	bh=2tHtFwFoGoH4ZkoJGvDew8nZKC/G8KnGEPLCqw9Jtuw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Glz0jt7m3X5A/j8n70CKBATZxgoT6jsvmPuAZUh8xZRSfAf0iFEv9MrUz3bLcnQoYT4sfkiQFrsW2CYGYKVJZRRI8zQtCmnRUj1q4XTFxG0ncwp/xPKKjlaDgmCX62ifn/NRh+CWtouuaxlo8alItt8VCrk/UOww+xafZzquKPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0anHRPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADDFC2BBFC;
	Tue,  4 Jun 2024 07:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487696;
	bh=2tHtFwFoGoH4ZkoJGvDew8nZKC/G8KnGEPLCqw9Jtuw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K0anHRPwZZJ9yhPag8x0MBgedU8UWdwWipStocGIHVncgp+yyy2mEWUMNun0BfiEh
	 o0lxvPdjHhoD0AtQeisMWfsEm+fVcN197QTeu6g2ZQlGCo5Kd2PAIkKODWjTaW5btx
	 //kDKkgQZblGWmAa9ZDj8oywi+FHjlTH+WeGol5AEWeEtBFi1onCAWZX9I4NiFbfMy
	 R0yrG4rMKv0Uw+cBJT7EEkx17PeNUGZPf/UCbgEPY/HVuPKSHTcTOLpwnSHcB00tn+
	 OndBeo8aFOMXOpFxzekJ/qotx9Rts3psuD0or03Th65uv3laLN8hMTEQfJ8R1GNgAc
	 uhhLXLXzoOiZw==
Date: Tue, 4 Jun 2024 09:54:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Paul Dino Jones <paul@spacefreak18.xyz>
cc: anssi.hannula@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Interpret 0 length ff effects as infinite (0xffff)
 length effects
In-Reply-To: <20240521220719.niwhskc473he5r5o@zitz>
Message-ID: <nycvar.YFH.7.76.2406040954160.16865@cbobk.fhfr.pm>
References: <20240521220719.niwhskc473he5r5o@zitz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 May 2024, Paul Dino Jones wrote:

> Greetings,
> 
> More and more vendors are entering the force feedback wheel space, and
> many are supported well by this driver. Unfortunately a lot of new users
> are hitting this issue.
> 
> It would be nice to have this merged.
> 
> I think we all agree a 0 length effect makes no sense, and this change
> wouldn't break anything that sends 0xffff.

Could you please make the changelog a little bit more structured, namely 
what is the user-visible problem this patch is fixing, and how / why it is 
a proper fix.

Thanks,

-- 
Jiri Kosina
SUSE Labs


