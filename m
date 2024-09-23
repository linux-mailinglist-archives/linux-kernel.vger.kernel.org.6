Return-Path: <linux-kernel+bounces-335964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9889497ED37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E90B2188B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D619D07C;
	Mon, 23 Sep 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QPerjNNA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFF195B1A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102068; cv=none; b=HttneaRHj+/D8nHpTpZlq/xgIkH6VidcAdj+2zMQLuzFsBxpOKhnQ4aSv9IEFVtfiZBPfsDxsGXF8/8CrrR4pP1BMhif3nIz/10RYNh0QueGMEPKlJOsq25RZBVp3aYTtPrNvljousbubUEX4WDf4x6y9MsZBw3I/bCzn+bdBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102068; c=relaxed/simple;
	bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn71Eq5nZuXQOT/JXQ0WYA0jMCcKoT0EObcvayHZYvLj0WYtXsBynR73OWj3FQXOXbTd/rEEl7D/n0Py4ikEmdJrPNqWIn2zhS8YQy7T82oXQ9aJVj8ix+FpMMJrP9GW+BfLAABNuerJjadCDrkai5BahvXwTNiHF+SR1+mGNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QPerjNNA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso749940366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727102065; x=1727706865; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=QPerjNNAunT8g3oca6cMyqkWg91JFmbqR8GZv/t0dBb6Qgfl4wPfs+ItdFnLzPN5Aq
         nEzNhii9S20L/H/RYVbrOh0A3zABsPHNNdm4oycwVtLkhc6ziD0WzzyGusAc7nMapV++
         guf7HPqoCUi58x+wKb5YD6aTrOSTF/vo2S9CfKNnErUaFVSkNCiQpNVTKf2YC+Y61bob
         74RmMU5yhA14nkVH+Ktz7W+rMt3mKf5UD4x6EPc7a3LRueVIYLLNc1luXRJPzEUvs8pi
         2eXcDTt99KjbE+NGrlkyAETUGUz+k+/DK9OzsMPowX/MC12q+V9OtwnhQQfgVv4WSRmG
         7Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102065; x=1727706865;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=exxK7VE8faT7BrOQ+X4QgAEICAzIPFw+c3GSkSXGqTvFVVjTppzrHalMkIr1pSkDGR
         ltd9EPWC8HGuuK1tTntc0I1D5CkbBc4EsQRAjgTqPM90Eidq6lZ/PF87iyJiW+7SE2lr
         KZvKf2pXAGEGH1cDnzrxRVGwPr2PpKA6s30WZGz6dOu+HSb2Cmrhg08LGa/AhiEsz8U3
         4/KAzxzzc/0QWXKwpxy7GLzPSZuMJS2geAJ4vXWFi+VNJtshDQOgqCfBq0pjYF+sueeW
         /+MD1ot1RzmY+IY09YxS2Kfj7oDGCZeAcROY5Ub7vHwo7wT05AFRdRa2Hf6uItoxnYqs
         PdRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4A2DwHa3s8LjoIgij2pIFz9c2NIo1yRsNKHdSlKxXnX2WKGGZXLrI+UKtaGwbAJz2KdjVA6QpoPjXky8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEexua6UEkhnHCyyuTlAxBAUP66RZ6HlqeThwUPsMQD5bc3bP/
	zynt5ZSy8GhUxpocAR8c38WqIjhjlDd7w6ENgOvxcAjxn9vNMw6IVLVADaCImM4=
X-Google-Smtp-Source: AGHT+IGvZ8CQKXGAuBIihvOK7BE9/Z+R3v8H58CSqqO0KjaYyKlCLQW3ALuIjZIDoyqq5B9b4jxJgg==
X-Received: by 2002:a17:907:e64f:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a90d4fdf82cmr1225911666b.8.1727102065503;
        Mon, 23 Sep 2024 07:34:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38d3sm1231298066b.120.2024.09.23.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:34:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH v2 0/3] Allow sk_lookup UDP return traffic to egress
 when setting src port/address.
In-Reply-To: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	(Tiago Lam's message of "Fri, 20 Sep 2024 18:02:11 +0100")
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 23 Sep 2024 16:34:23 +0200
Message-ID: <87v7ym7828.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Just an FYI to the reviewers -

Tiago is out this week, so his reponses will be delayed.

