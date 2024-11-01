Return-Path: <linux-kernel+bounces-392420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EBA9B93EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C27628177C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC21A7273;
	Fri,  1 Nov 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gykLoDI2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D83EA98
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473432; cv=none; b=MeNEAdF1IPRVvtT1xKsYPQnmqkqBHf2j/r1n0XNNqzFfaqvgflQBLise8VOAev5GACuYsQ9ANNfy415V+5f+XX2pEsK3zJ0H5YmluR2DiVo1L440xjFuWyXOIDHRGwVm9P6krEPVNjyTyNyF7Do1P2WJlEPph02l9Jw5oNswXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473432; c=relaxed/simple;
	bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg+ZxtArpOPepJTmGH1QtQ5X/K/vAiKuaHdPLkG5ccwV16cEz4lVfQOTHEKEr4HN82z37qCzglsfKFCMTvneEyNanLEsheX1pfLDB1OSwm53xOcj2QKLIn4y88OtC6UmFv78z7ir87J7WFNpSuVrpb/Fay9XpPmfBhViwaLNVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gykLoDI2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso114875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730473430; x=1731078230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=gykLoDI2DuEq5oSSJLE5frs0TT1DzrL9IFrqPAniiyuSw+ZykdIBnw/UHL4dx/GbrE
         hRE2UznsEjvBJ6SIEOyPdmy5xo+1hLNbMHmwLDmWxRjzIiKFhzy8IAeS79c2OoO05oC2
         fYm0ASM1GRpefBFIQHh0pQ0GWq8pLI6XHI26/1AQ44vT/auSOyz3Sz/DZwKgRGqB3Y5l
         08Ux/kwLyrE0DOcMHM3uf5yAi8SLl191LCURJs5Ndz4Y/yDKL+s6XSFjYi+9LePztRxL
         PA1zDeez8146vRU8UJBZ2B7C0U8HpZsF+BzIvnF3bHNdo0Ko2hadbXvpsZPoQXybjuZX
         8d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473430; x=1731078230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX5sq6ZheiFtKApdJRRA0qJIqMgD+DQBat0h/g373yk=;
        b=oH1DQxEIrocujD+IxFxGNrqnrw1K6kb6GcfcBQViSITOyk2fjF3cBVwO4jkViRMfho
         noM6KgE3olL7VR636CUgItA3qTgwJ0HJVSW0OHaevIYbUUTapO5FtTXHtrb3ZBPnEAoh
         SjY4sOar+S0zj9k3uLBZ/9zspo8SgEujzm/o/Wj8EcC1ean8v8oeG9eSg+IEz722axql
         9CdJpm4dmFblO+Xce8ANgOhHWlpCd1hGmmBsHhPvrtTPpTAta0rgTWuvG5XB4XXzcTH8
         TD14+8ajM1ja/pjdpe7FHfTPJGAQpZgAVZfEdaacpVkKXct0tqkXhFLUNjw0nzxFDpJS
         fM1A==
X-Forwarded-Encrypted: i=1; AJvYcCV2QZfFY0RSmiummRV3KLJMzxNnm3RbZeiMwEW4Jbzkoj+1jOR3UKULmfbEcTDhIwpc9czk7sq7b7Gg8Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMdRbE2mc7yBXSqsRaswNzsjq47IEuQc/SA3LK5RrEKSBNu8ZY
	m/s+wbBx1AvgmfIlMblmJHvzWly+9/WfYJOwyHtoCXFyMlZPs01JzYTxBJbJWckZivLsy3dppxi
	u0Kof0pT34gf2DGj3kSd61OpNovw8F4UPAn/fCTVX8kibdYZ9Au9lGeg=
X-Gm-Gg: ASbGncuQPAGV6TXwLc8a1LU3naWwIHsNaXbqLU4Ll5ca48oV+oSza0EZXV2kAfglDCr
	t/KCMgegDjVzqemKv4wKYCuZsl8+CUJE=
X-Google-Smtp-Source: AGHT+IHO6aa1H4NDIW0E9d+zicp8WZuquwRCLAb+vHiEevpZxqwYPVoVFHQYByqn3yh/phUy4h+4QI3F3VXJog6wc7c=
X-Received: by 2002:a17:902:f684:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-21105425eddmr4269565ad.5.1730473429797; Fri, 01 Nov 2024
 08:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031210938.1696639-1-andrii@kernel.org> <20241031210938.1696639-3-andrii@kernel.org>
In-Reply-To: <20241031210938.1696639-3-andrii@kernel.org>
From: Jordan Rife <jrife@google.com>
Date: Fri, 1 Nov 2024 08:03:38 -0700
Message-ID: <CADKFtnSvogoT0ArYUqUFaBVUoQN4tfX6i_OdHNc4h2kaYvpZcQ@mail.gmail.com>
Subject: Re: [PATCH trace/for-next 3/3] bpf: ensure RCU Tasks Trace GP for
 sleepable raw tracepoint BPF links
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	rostedt@goodmis.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, peterz@infradead.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

Just to confirm, I ran the reproducer from [1] after combining this
series with Mathieu's from [2] and it ran for 20m with no issues.

[1]: https://lore.kernel.org/bpf/67121037.050a0220.10f4f4.000f.GAE@google.com/
[2]: https://lore.kernel.org/bpf/20241031152056.744137-1-mathieu.desnoyers@efficios.com/T/#u

Tested-by: Jordan Rife <jrife@google.com>

