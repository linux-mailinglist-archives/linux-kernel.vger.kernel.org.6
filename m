Return-Path: <linux-kernel+bounces-309797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91016967087
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E6D1C21A42
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD0174EE4;
	Sat, 31 Aug 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4Z1/O62"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38814D449
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097281; cv=none; b=MGC9Spxu3WeIXHxNTcVMUmrHVEXpBdZz5NWQrY2n3g6NGc6MqrO3yV11iEhwepIGbFTzUYmomlrltqlWHhVNpxfu3x7wlC42qf2X1jxTd/Xl+LC2kkZW10CG/cHy3CSIc8ZxCiMyOhMpuoK/rWONzlk4OLjC744E7VSKzgsolF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097281; c=relaxed/simple;
	bh=P7Ay73iPkGu0MmbyS4ClIVJhfFRmCWoeq0yYnn8GQ5k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g2N55XGgGci3sG++9DMnwK63WAXe8xVtBHBmtKC+upEqzoRxj0uV9mitkxL6arqzEDHD49d6/zWJ/94vHWBJL2nSERcRj6Blo0RmC73ZqOoZLAXZMY5UiKY7PV7oia7knIJ2iL72jFA89aRSlFyzF8xA6Mp5lx1Q+eVeOaZj91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4Z1/O62; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f406034874so30654771fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 02:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725097278; x=1725702078; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Ay73iPkGu0MmbyS4ClIVJhfFRmCWoeq0yYnn8GQ5k=;
        b=H4Z1/O62d7qTp2H10zEwu3TfbFmQCH0vrYr4Z4NNvh2vU2BX9u67TwnEnsQsjDZSbx
         701HKLetKgKI0BMuht07m5u9/xZljKXYV/mlSELZVZbha9qE4o1NwaoBQ4JH8UMhra6b
         y3h1fU8ERVN2ZYs1PKH5vPHPp/joJcPtqfWaMFFCPifryaGp0Nmp6MbDmOwp3oF4bzHC
         r+dUhKqDfyuceKxrtPkqR9g6QeAK+m7HLgvos29MVU95RXajNWf546MFIBvDJi8Oye1B
         ohwSQyt4PonSoR6k4Pp3flYjEolrdmHZe1/taIi8MYhtgehBn+a34NkOt9QGtv8ljZNW
         fnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725097278; x=1725702078;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7Ay73iPkGu0MmbyS4ClIVJhfFRmCWoeq0yYnn8GQ5k=;
        b=RaZWeSZ0GN+gOsISBD0ygEb5uJvXmwLu8fjPqTBhklCJWk/BCwafHmQteHMmGKyUvJ
         1aQmmFh9AHMIEqdn99SR5EyJhE9tr5FRLjt6nU1Sfp7Z+HrnrR/Gk2IJREmvGGrDrBRc
         gGBX+4d/IkFD59+VAIM4tKPRdQagVqWLueAbU9noITIOX6WOn72K0+Wed8I2liKXQ8bz
         e2LDb4moI7vlMfLzk/nMJzQ7YLgGCuieRQCcqwtGRwfvUCKsDhbhnyGfYxEBNbBUt1LK
         YNxkJmptaBWq6M7k/JpcdnqCmS4ye5VefouvCDnibHJdd0i9DxRj/XYTyQ8n0+52B+yg
         5f4w==
X-Forwarded-Encrypted: i=1; AJvYcCWvrzuO/bfMksD+wRVuqPYD1H5fBWVIeKCQZqaYZ2AIH+PM0C0IwgGDIIe8/FekDw4f1KVPSFKxuXe5slY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfs1EbhMS/Mm5iaayrUIeTrlWho01kwwsSJeAapScT9Uaw86+
	TD/NIZC5R5DZ8+Nixhyj6vewRcsjMUABCJ2idF+v6vXfCrCzBj0+
X-Google-Smtp-Source: AGHT+IH3fkry8a2MdNWwGeiNc3HZ2o5AuoOQ6W2Q7EimLQjOCU+/sdxJFuoHIQfJ0l3SALypmKxrxg==
X-Received: by 2002:a05:651c:548:b0:2f3:b078:84bc with SMTP id 38308e7fff4ca-2f6105b5d9amr69678851fa.4.1725097277549;
        Sat, 31 Aug 2024 02:41:17 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615171d68sm10033141fa.84.2024.08.31.02.41.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2024 02:41:17 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
Date: Sat, 31 Aug 2024 11:41:05 +0200
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <277CDE7C-7ED8-4840-9C30-533C9327B028@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
 <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
 <3D1B8F1F-2C41-4CCD-A5D7-41CF412F99DE@gmail.com>
 <CAJD7tkbF2Cx4uRCJAN=EKDLkVC=CApiLAsYt4ZN9YcVUJZp_5g@mail.gmail.com>
 <EE83D424-A546-410D-B5ED-6E9631746ACF@gmail.com>
 <CAJD7tkZ01PPYMzcTyX_cwr836jGonJT=fwT3ovc4ixW44keRgg@mail.gmail.com>
To: Yosry Ahmed <yosryahmed@google.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Yosry Ahmed <yosryahmed@google.com> =
w dniu 29.08.2024, o godz. 23:54:
>=20
> I also noticed that you are using z3fold as the zpool. Is the problem
> reproducible with zsmalloc? I wouldn't be surprised if there's a
> z3fold bug somewhere.
>=20

Hmm - yesterday i recompiled 6.9.12 with zsmalloc and =E2=80=A6. after =
16h of continuous tests I can=E2=80=99t reproduce issue.
With zsmalloc 6.9.12 looks to me like stable.

With this - what will be your advice to move forward?
Is there any possibility/way to avoid bisecting? (due limited time from =
my side)


