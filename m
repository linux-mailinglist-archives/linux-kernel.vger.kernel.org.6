Return-Path: <linux-kernel+bounces-297795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723D395BDD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AFEF281DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504E1CFEA0;
	Thu, 22 Aug 2024 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A0TnMeyY"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268418D64F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349482; cv=none; b=HWrs5oVK6tYjSrTiCxRidoayjyBvKcuObjub5dopKGINBjojU1q1VdCaQ1JZFFueJFndouIT0Np+x1OpDj1A6hOUYx/ZLg1dFRPpr4mF6ikvDuZPeYAGhaoDQ/wJUic3tn3No/XnYW2JzekGrTl7WA09KNIv/6dNY2xTmp8DQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349482; c=relaxed/simple;
	bh=AyQnYoPe6sf/wSyLAOYvZiLsLlNC/z1c6uDn8wvCjt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVgTyzSoUMBHUpNTBFYaOZbIi5QcE1M6fO2LApTJ2wYxgiLAzfccmAmhW6/HyVDBLBItXcTcGzHgw2Xpe4CrDeZc9OB5oATegmrdPJFCQNwRrIBQW2k1bH+oIzsUzieaA9jm9FDIdE3oRoVZgk6/ZIsnX50DNHyVPU2NR+Y0Y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A0TnMeyY; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fee2bfd28so27451cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724349479; x=1724954279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOajGVKCmpE5kmdw/T7Qp/wNBvNSdZEW8S+OXk3bvwo=;
        b=A0TnMeyYdHzSVj/b2HPYdhkBusch8SVI34fBwCpGSZbzyKirr+eshjNsd/eyeq1DmH
         oEr82q5XOSGB1/Nx1BGV2zQLPQlIgtgpFR1pZc/iXchTci7b68j1vVkIGq1uzemWAQw7
         hekHQKnm1CFInFEdfnZ5IOA/Z+sChhxSlyDv5rT/jTdD8P+xRkRAlrAlRJwEa2FFSirN
         vHVDlAcwUKdM3bd3GXaNoSv1CHgBKVmFyLN2QsL7RX7KF1f2EBLwd0bh8hMWDwuK3UUP
         xR3QqYAs+OYTHkxpYBIniCYr0vKfRzi3DFiIBdFhkOnhrr2vDJKE9fFiYcdeIBUaUajI
         nnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349479; x=1724954279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOajGVKCmpE5kmdw/T7Qp/wNBvNSdZEW8S+OXk3bvwo=;
        b=Vh2sjVB6tuoOmpbj7O1jg6ttp70qHzpCKZNFNFY2y1LFthPS3JQQ2q0qhNiN05Ub74
         Mc/x8WIMSmH84giD2sBep9MmopsdX+PS42bQlzES8asinD+6c2GrA/Uom3ejG7gy/qO5
         yvpRVyyyRbGMBzatFSEpApbwy5Blf3CdtmU13gu6sFdojVwB5Tvjp9F6aj/TdFii1vKa
         uaHNztshE3jMVixrQ/Z7R/k9QPBD797KjDnM4iHz1MWAjT19VksN9vs6kyOSnzdlHE7V
         LfGWfirusoMSAJ+W5lHR40ly/FU03gZM5+VFMug+TgzsQABVWn2h3bYk6qDIzleMai9C
         UIFw==
X-Forwarded-Encrypted: i=1; AJvYcCX8satF69YN5JEBkJ6i++HgSxSKZ63dgAlJxyYkKa5wnKFWOLNUH7vAh3y9UBZDm7OjX+wzk6mSdV1aC0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrW7PWt2xpRi8fhw7MLX9hIud9bd63b9+YEicYc58KMwogds9
	D5Vav98P9a/vME84MteuHzcv3hOe2/oYymMEtqvokIKZibjCE1K/N3ipVdtDBGPRffXAqFVFqhu
	zgAjh4e+3ljgHehi+tSUP0gH4ElOP71SmkO/A
X-Google-Smtp-Source: AGHT+IHpOQGA1+Xvu8VfAIHeP2jPYfCEPVVyYq8ryHdwZRdhtAaz9lpYz6WE5A47PoBLoqFMm3zfFnuZRf1AcYxhCf8=
X-Received: by 2002:a05:622a:1b91:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-4550859549emr27021cf.29.1724349479217; Thu, 22 Aug 2024
 10:57:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com> <874j7ccxtz.fsf@trenco.lwn.net>
In-Reply-To: <874j7ccxtz.fsf@trenco.lwn.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 22 Aug 2024 10:57:21 -0700
Message-ID: <CABCJKud=YO=fxF_tmX1N2ec66Rzqh8RsaQu0qrbC5WB529wgWg@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] Implement DWARF modversions
To: Jonathan Corbet <corbet@lwn.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Thu, Aug 22, 2024 at 9:43=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> Sami Tolvanen <samitolvanen@google.com> writes:
>
> > The first 16 patches of this series add a small tool for computing
> > symbol versions from DWARF, called gendwarfksyms. When passed a
> > list of exported symbols and an object file, the tool generates
> > an expanded type string for each symbol, and computes symbol CRCs
> > similarly to genksyms.
>
> Potentially silly question but: how similarly?  Specifically, do the two
> tools generate the same CRCs for the same symbols?  It seems that might
> be important for users transitioning to the new DWARF world order.

Reconstructing the source-based type strings genksyms uses from DWARF
wouldn't really be feasible, so the CRCs will be different. The
similar part is just that we build a human-readable string from the
debugging information and compute a CRC from it. If anyone is
interested in switching to gendwarfksyms, they'll have to rebuild all
their modules too.

Sami

