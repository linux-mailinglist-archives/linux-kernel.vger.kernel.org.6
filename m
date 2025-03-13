Return-Path: <linux-kernel+bounces-560320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8340A60246
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FB77A77D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B751F63D9;
	Thu, 13 Mar 2025 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgF1UiRl"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBBF1F4E5F;
	Thu, 13 Mar 2025 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741896790; cv=none; b=ezNszBCZpU++3msjVSTMomfECnlsJ130sEiOryUAfFVmpQnzYv0VAzJcU7zolQtwo7O4jO+yWkAgoC3Q4p83S4BUi4hmgcgWHCr7IHWz9YGe2PidfRCrKFltRNsZgtN02SXm42S9pt+EUiEIYUYAIpxYlGeQi4oPAbZbYmg209o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741896790; c=relaxed/simple;
	bh=bEd8ptZgqXjEJd5xd8bgghUaCfzqJSWWlHm1VpPWV68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2WapHcV465tmBLHRmJDvVE1PaSgSNjXecQMG/fBnVhPwSw293dx4JgY+liV/Fp8Mn0H7AAxupL2/PyltUZ2bInU6ye1Mdhw+7YlYTd6OD4ZB4OvK6kC41knK+Q6ERyVi06/BHyJkoaWWe4zTrE52ZCD19w7vqYBPzIUyw5rne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgF1UiRl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c559b3eb0bso84647885a.1;
        Thu, 13 Mar 2025 13:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741896787; x=1742501587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEd8ptZgqXjEJd5xd8bgghUaCfzqJSWWlHm1VpPWV68=;
        b=QgF1UiRlcmlteSIBPyU9+uli+RUhqS3HSBsUjcaFLPnHPnhmQqyr4wDgUnHyeKEgE+
         j1aMcinFYRVHhK3KhJO5aXBwRhl2kSxvozUhSB2vJrGUKQH8xLAfB1W3a6pnYSKNI+j3
         5BYIqmMs9a9JbjGaukVOKijemG1QUAYDYdpQ79yNnmzqQ+wuCDuRoaN91PuJce8/MfB+
         WvYTlTHCTUWqpXFn7IwB746FosxTUoY5PBb+E8kt62InZBOuWHaB4gStk3e+uiNMqw0H
         apT/p9cvAK/zfSmFfgKBickGhgUYyaJJOCQ+n3EtRN3+Hgkxo/Jjfua2V+RDiTDuE1Z9
         JHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741896787; x=1742501587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEd8ptZgqXjEJd5xd8bgghUaCfzqJSWWlHm1VpPWV68=;
        b=oh5+/ucXJlOEGbhGcwoGZp8eQTXSs+FCWIEV6xA3gjoLxGN67OZ/WXxTtFUbS1frYS
         ltp7s+UJDEFeOMcUOmNwFRtGwhVScnUQRkWH3foL7rGD3IphhsUUA+6l0+lM1xsQnwZk
         /Si2GlSFXaPnhuILDlw3/TaGrQ0W6NAeePiuzSreL0Dv1xn7NwWAhJy2SGeURXb8IlFk
         lILZoxla1HACU8glQZVMRVSkTOBS9I7ejxz5eHKw9VIW3sJleXWuGfNkJW/MGl8hU+Zr
         SzvwXUkAPtT8xuuBUbS4IjC8bUAm4RtoPqcnsqVCTPwwZgSciwR6ENP23C4RvutvKw2g
         kk+A==
X-Forwarded-Encrypted: i=1; AJvYcCWeXFh8TJ1Jv3NcdlUR1CynayI12y4F4iBHlgdcrhF3UPPXF5FZpK1imoIqc5ZdOw5MjwcmCo9iapV5N7E=@vger.kernel.org, AJvYcCWjBUXxo4i1gKNs2AWkomL75Pu0xKceClBF41cOqlqxiuvfyvjQ8dU0uHAu08FSYDjoLJX5fGrJxY4=@vger.kernel.org, AJvYcCXIfXb0dItwLQps8x9T6bBf86EJjiDFAc1GbMRCm8ZZ0wmTp6ZgDXvMYnvnxq+IU+Sa5fAOh1/cZC3HrkFY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyer2WzcJe/H8K5X9S2DTkt1jrDNr5lf1rBnGeKSSnAqg1Lr21/
	mzZskdyajdlHVYU9KbzU2aGVUtJyDLaVmeBL9Lbp7aOUm7pQaYI44GENSDbTl9Wcr4cjRLR80dC
	EoI4v535vYvnfoHcDSyl6W1XIqV4=
X-Gm-Gg: ASbGncuBEFLtp3VooUk89DrzXB8tEqP3BGebjPkik4ioKMjNBZnmuQH6h5J4abZGQwR
	8rRyKy2ev8O/bRLoGamfeSSEjxUpHOFGlW2SOszySJ7FFvDuGj90tT3agCJFByjpA6DUZWE58eK
	M94cXq1eooyDuCHzKKs2+FG/KqveY=
X-Google-Smtp-Source: AGHT+IH2YDtPeC7j9KFqSfejuDV7d4P0yUGe5MExJOP76T0TCfjkJPK0bkdccLaJh802t2zzNAXeplDeL/IkygtAM10=
X-Received: by 2002:a05:6214:c49:b0:6ea:d393:962b with SMTP id
 6a1803df08f44-6eae7a3f381mr18737416d6.22.1741896787438; Thu, 13 Mar 2025
 13:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-gpd_fan-v5-0-608f4255f0e1@gmail.com> <20250211-gpd_fan-v5-1-608f4255f0e1@gmail.com>
 <f1364387-3087-4747-ab77-bdbb62abec7a@roeck-us.net>
In-Reply-To: <f1364387-3087-4747-ab77-bdbb62abec7a@roeck-us.net>
From: Cryolitia PukNgae <Cryolitia@gmail.com>
Date: Fri, 14 Mar 2025 04:12:56 +0800
X-Gm-Features: AQ5f1Jr5EaFFlVRpTxuDiQ7K8_46YJ-IT7vNpafcuBfheGbFAN8D5LUZXbMrCgY
Message-ID: <CAANcMP=ARJU_UA=aOB7=TzxsehoYQ8Zs+Ot-MupHkzRjMVfH0g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] hwmon: add GPD devices sensor driver
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	Celeste Liu <CoelacanthusHex@gmail.com>, Yao Zi <ziyao@disroot.org>, 
	Derek John Clark <derekjohn.clark@gmail.com>, =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>, 
	someone5678 <someone5678.dev@gmail.com>, Justin Weiss <justin@justinweiss.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> 0-day reported crashes with this driver applied. Please fix.

Fixed and v6 sent. Thx for your review!

=E9=A1=BA=E9=A2=82=E6=97=B6=E7=A5=BA
Cryolitia

