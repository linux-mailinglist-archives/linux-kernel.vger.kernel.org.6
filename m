Return-Path: <linux-kernel+bounces-522079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96AAA3C59B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0597A837E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE621421F;
	Wed, 19 Feb 2025 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy04ZVnF"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F45211707
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984694; cv=none; b=J/F7ntNRFXjcxldoAOYAV68ypjQ1f7kIYh4qLIMTB7UkI8F4NFEWpfKiy4XpOrvWzvdEIWb+fQZnWPNLRjwf6bYhZD29Bk42//T7H9QA5rKdpa/BauGCIU+KpnKjGDIA7ziFYQR7EDuMGqAxkhjY9tWKOzbRtjVloOgWX4Ep4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984694; c=relaxed/simple;
	bh=cracGUo1zCzzxkaCNPosd6J3mpz2+hNZ2bFnIvrArOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6rIxJ0vZgTDFB1Ag0THVEfFH75h5dfc/JzJwjpGCK5r9wuBVDjWEG9Bh123t4EtkkqoYTL25IJV3j/BsKtVysVTba0vJrJyJd8Ow7TW5XyFJdSVx+gbOlke2SHEwP/kmtBfm3vq2YzBMoPrV+oWuRqTZrWpwgSuAQzQmLShBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy04ZVnF; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2fc4418c0e1so1971225a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739984692; x=1740589492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwbHG79zVjrfg8l2dT+ak8dJ+hn3Pam7eFOYuymMrKw=;
        b=iy04ZVnFQV1tVEBOEwLY3GjKFbaDH5w1/ha2HOxTvV+ikBBI9qAiIrXwgoFEFRkHim
         8ACQGip+JPw6ErdzOeI/jRfiSGLrIA6xH5zUX8c8vafQDD5aQyqOO6pmiFu5h6+avo9O
         EHe+Gix1OqpYcDu/oKCAtGWGS4iucuqjBZqLu1I/YXp1a74EiX4RqKnr4PazNvH3O7si
         n7fSvS1TTLefo4ZGQ8CG2JhCLck9u6cnzCr0yhEzt0x1fJ8boG4TNK53EGyw0ic8Ka5a
         j55fSNMygLnZnT1QWoHk+e4CMJyaLYSWW343MfOvq5d+SyKzix+u8RsknMi/gS0XqQta
         6fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984692; x=1740589492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwbHG79zVjrfg8l2dT+ak8dJ+hn3Pam7eFOYuymMrKw=;
        b=XeI/ueFNJ9xy8dDYyBZ8Fco7Na9O3Z5wiPQIl/6tsWXfF0UDCurFaC5JdCwcXDYP4c
         LurwNecuMMbMmXUTEWI4jepLrmAG2e5AX/iVzPuuzoUCsX7fwh5VoQrkVtqXk76VBKSX
         7vKouDCZNMy6KxfLFUCSKHOMM2H3nNKkpEMeI4JIUW/l9dbdg98bzD5J23dQIzS/n2h6
         2QjT9y+5AHLBrr16VZ4kAMDrPtuxV826zG42OI0xVGsAuCkMthzbLcn+TDoex6LHS/ee
         qidR8CDHMYgLDGf7EhZOHLaUd8QvZSZPDabbBkHnnovqApP3mzepNbBic8PQrJ3uudii
         9mnw==
X-Forwarded-Encrypted: i=1; AJvYcCWA0+Mn4FzpkEivTiAbS0/QkhYvnnuxAS0bAU8P3F5MF36+kg2ZBT5VFSzitvI/ro+hxGlamuYKEWH6TOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53qtqgLOg8EKb4T4pOZ5iqW7ltahVFm0X0suFQF06mTs6dFwL
	CRq/2NZPcl2UOFytIS18TzcOFEXoNAfV0UKoQYGzc4PklbrGc3UjEh4WDbrg47U=
X-Gm-Gg: ASbGncuf5mZNbJaffuRvFsHnYLpzk+aLO1p1xSaQ2fwF48gLTH1WfL592G5xaj8VGLv
	/MZtjoiQK/71ywmYjyWMgmk74vdKHJuv3eWFr1lrvxwQUP7WMcCVNzhJtGDKJ7eDxyJOC1iUrgc
	9RyfOb+fRqfKARR+EQDSFnNiojIb+VwvNJZrdvaXBa5OHUNBMTpeYKM2fFSRGhoVNUVmn7JCgaR
	MM7RJwDFZQoE+8C0umok8T0+rs34ouPTz+W8WVbPn1OGRMODTvvyhereS8Jpv5MAdn/LkkFelRF
	f/BzsE5F+lv/euwe6mg9
X-Google-Smtp-Source: AGHT+IHix6sPuQU1s1oq8du0esyShMVQM4JFrJLLIzRNRkZSxsMrw8z9/PBeS/Wshodv16NtVTbIeQ==
X-Received: by 2002:a17:90b:4fc7:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-2fcb4cf0c9emr7104913a91.5.1739984691795;
        Wed, 19 Feb 2025 09:04:51 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:e1bd:18fd:9875:3b67])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fc13b9140esm12246906a91.30.2025.02.19.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 09:04:51 -0800 (PST)
Date: Wed, 19 Feb 2025 22:34:47 +0530
From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dpenkler@gmail.com, kuba@kernel.org, rmk+kernel@armlinux.org.uk,
	broonie@kernel.org, arnd@arndb.de, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging:gpib: Fix error message formatting and
 adjust memory allocation style
Message-ID: <Z7YPL19NcVG7loqt@pronto>
References: <cover.1739794938.git.kumarkairiravi@gmail.com>
 <2025021908-fraction-impulse-7bcb@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025021908-fraction-impulse-7bcb@gregkh>

On Wed, Feb 19, 2025 at 04:52:13PM +0100, Greg KH wrote:
> On Mon, Feb 17, 2025 at 06:26:15PM +0530, Ravi Kumar kairi wrote:
> > From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> > 
> > This patch series includes two minor improvements:
> > 1. Updates the error message format for invalid base I/O addresses to use hexadecimal notation.
> > 2. Changes the memory allocation style for `private_data` to use pointer dereference rather than hardcoding the struct type.
> >    which is perfered by checkpatch.
> > 
> > Ravi Kumar Kairi (2):
> >   staging:gpib:hp_82335: Fix error message format for invalid base IO
> >     address
> >   staging:glib:hp_82335: Refactor kzalloc size calculation to use
> >     pointer dereference
> > 
> >  drivers/staging/gpib/hp_82335/hp82335.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > -- 
> > 2.48.1
> > 
> > 
> 
> No longer applies to my tree :(

yeah, I you applied another patch that fixes same issues, I just noticed
it, guess I was late. anyway have a great night/day.

regards,
Ravi

