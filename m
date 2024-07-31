Return-Path: <linux-kernel+bounces-268377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB169423E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F4F1F23859
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D384C83;
	Wed, 31 Jul 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POt+FxEs"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700B4431
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386355; cv=none; b=MhT6qxCEzOEinKryLJw3gw4M2PVYppY0q9ye+MPyhu/k5RlPBht3E3r4aTdxxAtCazxRsa+Car+PilfmnkHqBGRZu0usnwPJKpyfvrs74ipgRcRz3KwNvDgtUoZUkYAUztuoLc3474AhTBaAnfgAmgubrH4LsFaeGT/2ouWqJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386355; c=relaxed/simple;
	bh=G78J1xazOqAfpXn0/qpj2FC1yrY6QemILkcM54iNNJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4/0mn9zNA3+Y+ABv+LrPdicQV0hTGhvUmjXZOkx4ag3IvTolL5myJWGu7OZPj3Ot6nCDWN+NbATkK32smqTxt9D+dSQQFHVGSwhgGuZ6Q1RGy7lSdpEwaBN08Li4X5+MbRfLOG/c9Bp5GrmUrjarUHcxP6zIkjgmnPny6mTO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POt+FxEs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f149845d81so13591041fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722386352; x=1722991152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G78J1xazOqAfpXn0/qpj2FC1yrY6QemILkcM54iNNJQ=;
        b=POt+FxEsq0xci85WWzYVlGXhx+XBrkySX8BqdFIWEy7Nso8vvV3a+K6iA7qTT1kvPb
         zmZHsCSHiPtMm1PAYTc3smbU08Yos+83umT3ff45wdnTbuzxqSfM4wcSb5cJ7Sk+nE7a
         01y8HvH9FCfzyC/JuuF1HdJXs2fT5afBP5CKOIDZ/wryL2cU7P0jMjlCdX5m2fSiXLTt
         BISdvdtwXi9o0Q/qUARD+akzIlrVYtfakvhQt+IiIgFl+crA02PginQQW43hlVO61evM
         GAUQTAf8SjfOm9dA7RnOBVoMSFUG+wp1FO/uyYmqnZfJrO62uvvP2VODZEntQ9YlJmnG
         xkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722386352; x=1722991152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G78J1xazOqAfpXn0/qpj2FC1yrY6QemILkcM54iNNJQ=;
        b=pQEDfPJ+TfhXSlZ+fMZukBHvwLzFHIZstZ4mfS6h/zGSw3nuZymG6Ba8jSXBPYoB1u
         CGJog7n1NxLcWyDqtsLiKILI5xl/Ubk7OIqgA6T7y8hgPO3j7LhlBYiRteWiDEsLyuMm
         Gynhf+6Zn+XI+9Opxt/g+NKRYtveUiCnxP+fS6HkoQlOiIEjauq6hFCx/rgc4Y+R1itT
         3M+Moiu7OT+MTZSfyVTIsxQY/Peb59sbLrG7CmisrDmQBGiXU8kf48s6GBqQri/dhECh
         dfxYIzvcpV4xhyDwRUv3RAqG0xdv5b5pk8TcdtYUNiAm4aODZzKrIZxkNUC79BQudau3
         rktA==
X-Forwarded-Encrypted: i=1; AJvYcCXkWRbtfvsz4ly3Ajv2m7hJMLDcBf6GPtzkurPzbShHG5C+3WxQGkarxtqd9Sw03vZnPyyHtvUhRgNHE/L3hNJecOnOfkXKmF329ZKn
X-Gm-Message-State: AOJu0YyHJLz0w1evaHVBOPiuBClnoyQ8lKgX0ckOF+JYZg1ELPlt1v5D
	hPFWPbRWjDSrpFCxrx60dQTSLR7gslI3ciR3ZAzOsCWA5j2PVxKowqkPlMLjO1DGA7WyHm+HofL
	XtPoCKXUktjZDFNu07CHdfvEoZ/8=
X-Google-Smtp-Source: AGHT+IF3QdcyfsTf73ofgzOHHFXCnAc6jKy9oxJ8bWdQTI0xNaDz45AIw6tugYREKf7IH9fo6GqtqCrB8RErPRzM3dw=
X-Received: by 2002:a2e:b711:0:b0:2ef:2e6b:4102 with SMTP id
 38308e7fff4ca-2f12ee626aemr82767921fa.43.1722386351769; Tue, 30 Jul 2024
 17:39:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zqd9AsI5tWH7AukU@pc636> <20240730093630.5603-1-ahuang12@lenovo.com>
 <ZqjQp8NrTYM_ORN1@pc636> <CAHKZfL3c2Y91yP6X5+GUDCsN6QAa9L46czzJh+iQ6LhGJcAeqw@mail.gmail.com>
 <ZqkX3mYBPuUf0Gi5@pc636>
In-Reply-To: <ZqkX3mYBPuUf0Gi5@pc636>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Wed, 31 Jul 2024 08:39:00 +0800
Message-ID: <CAHKZfL1i3D7wgbdLWz3xiK7KkAXAxrsyQjFmFarrM94tJPYh3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmalloc: Combine all TLB flush operations of KASAN
 shadow virtual address into one operation
To: Uladzislau Rezki <urezki@gmail.com>
Cc: ahuang12@lenovo.com, akpm@linux-foundation.org, andreyknvl@gmail.com, 
	bhe@redhat.com, dvyukov@google.com, glider@google.com, hch@infradead.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	ryabinin.a.a@gmail.com, sunjw10@lenovo.com, vincenzo.frascino@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:42=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com=
> wrote:
> Thank you for posting this! So tasklist_lock is not a problem.
> I assume you have a full output of lock_stat. Could you please
> paste it for v6.11-rc1 + KASAN?

Full output: https://gist.github.com/AdrianHuang/2c2c97f533ba467ff327815902=
79ccc9

-- Adrian

