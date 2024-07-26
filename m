Return-Path: <linux-kernel+bounces-263013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A434E93CFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55761C21E97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35036176FAB;
	Fri, 26 Jul 2024 08:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bO4k0fkB"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E729A5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983548; cv=none; b=derS04Q9SckBWFr0sx4Ltwd0ZdQiATe38hjXjn56+3tHZzzLgTNBFkb9dHkJzc6VY0FJrzX5VjLc9nfYXN99wkuCpOD5tgTtrclQ5eo/LWaNPNlL4bNcuJl5yFXPqvsCMwrEk8RMoaMSq880PPJUzfa5iIdXyefnZTwaoY0UjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983548; c=relaxed/simple;
	bh=cpFuacOOU9PyOYqB0WWoaM9Cjcgmb9kMiCLGqJP8J2A=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ah6vC9jISSBakaYhLYfFw2USL2f/yMeSkuVCIHMKfI2sg9LnCSNx/FLfiHjNmOOLaXVSApN+Hk5HBp7kNPYrjn6WwK7iDunfvIIdD/VlNdnrJTlp5U6SMqgjFMHh+z47vTJBziypxXzUdgSKHaEdL4iCtDC6LZAW8WVlg3zBwKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bO4k0fkB; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C03E33F4A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721983538;
	bh=cpFuacOOU9PyOYqB0WWoaM9Cjcgmb9kMiCLGqJP8J2A=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=bO4k0fkBQRe173m3CGMT0PkuDlWQf0DRFORGVfmvJ6cLdIAMdDmlabedI2uoD7LIn
	 3FVUGPNjv7tIAjP7GLndUsNIxNiAyit4TuL37W3iUNKONaWtNmVqE4JXayJeCj2dXj
	 l6vutWhxz8LuSVhqnwiEyxMeC0bRScka3j9jZJn4t24hY1FQX9xq0/LkDZqednmL3g
	 WBu8On4K3XeSgnhf4grrQ1/GAYsHR93E3s4mQKpB4TybMPA/DQeI19CDhRi4BxclGk
	 t1LCF1d1yOVrHJgIX3kZ5lsy6tfVWL/GES9z5OQW6lfUFb4Yo5U9UdVS0OYHK58niO
	 wozh72TVF2T8A==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44df73f9ee2so5783551cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983537; x=1722588337;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpFuacOOU9PyOYqB0WWoaM9Cjcgmb9kMiCLGqJP8J2A=;
        b=LFxTElfBx0I1cU5eoNJHNoISr2llV8GL0K4CMBik2ofaJYeFg/Q8zLAkJHXhyf5zBb
         XGvW6NldWYhBpVxkC7VlHhHzWLqonUdiYALuIH1GvHNQFOfWkBeLMMoh5/fbkkPqmwva
         2NMdzqqIpwNdRmSCda7S/z9ZqPz+qjzuuaC7jAp3NoznbVNAv0Ip1dMtSKXdtHqoE95D
         K/DrkV9rl3aGNOZQAkYcpSq2LXcNq/m3ts9MLtiXCoEc9HBLLuhlT5Cd3QDmrtWuPJpT
         ZLBTSFUtY/kpu415zhpRSg+HNkpnEv9lYJd8Ugo/2EpUev42I6ShsqV4vAWkzJvQWgQh
         pFUg==
X-Forwarded-Encrypted: i=1; AJvYcCXNiN5aHE9tcsAbdFY3UA7xSZ05Mr3izLVV8Xzlw0bnDmP3c0HTibzlIXwbAlqiQcBOKcsYjcgajKndIizVwMeWA9z4AqLlipHQMgs3
X-Gm-Message-State: AOJu0YzMnivgvH9xUw7g+4KNtnDWhdTC9j6c7/5zgPa+KiRkxmwdSyrR
	fUHGK9Xl99FJxyuE6rCJCQnMaM163SudCUA9CdbFFhzip/6P4mei7/Au6u165S11JQa5cu7k7b5
	O049iTxw+3w064rgN0m6VoRALUtFtxkt4zvptdGSrogxrQVu64q8BbtQxsl3KhIhjSH0qQbUGSP
	tn6KAf0TXmSUwYPlx8X0MrduwCcCwH1TFGBO0EnEBNIapDG+K2rdok
X-Received: by 2002:a05:622a:11c9:b0:446:5bbd:4802 with SMTP id d75a77b69052e-44fe92731famr52404321cf.56.1721983537665;
        Fri, 26 Jul 2024 01:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfWGnnFaUTMrdZkP7xOyuSJUp3K4zWzDQyC1gqU+SG7p0SaPT/1zgZF/fTQCd4H5ucjGPzcBLx8KLTXn+dlRM=
X-Received: by 2002:a05:622a:11c9:b0:446:5bbd:4802 with SMTP id
 d75a77b69052e-44fe92731famr52404111cf.56.1721983537186; Fri, 26 Jul 2024
 01:45:37 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 03:45:36 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
 <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com> <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 26 Jul 2024 03:45:36 -0500
Message-ID: <CAJM55Z8iF8yV5JK5v6ZtQqS5AaWwCZ7uwhSYb7hdxh0juDFdqg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
To: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor+dt@kernel.org>, Drew Fustini <dfustini@tenstorrent.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Fu Wei <wefu@redhat.com>, 
	Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh@kernel.org>, Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
	Yangtao Li <frank.li@vivo.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Stephen Boyd wrote:
> Quoting Drew Fustini (2024-06-23 19:12:31)
> > Document bindings for the T-Head TH1520 AP sub-system clock controller.
> >
> > Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> > Co-developed-by: Yangtao Li <frank.li@vivo.com>
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > ---
>
> Applied to clk-next

Thanks, but this driver seems a bit incomplete. With this applied the Lichee Pi
4A no longer boots without the clk_ignore_unused kernel parameter.

/Emil

