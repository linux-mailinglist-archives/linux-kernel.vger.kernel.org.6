Return-Path: <linux-kernel+bounces-563590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E8BA644E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7031893DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B021B9F6;
	Mon, 17 Mar 2025 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIlFzduk"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6044207E19
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199262; cv=none; b=FSM6VqJuV24Y+4oe3lLZdj+JEIiE/HH9iGdOjIRCtleHhesxACnLdCOazfqNH1UJsLApWoTjeEAoMraCF/V4raREWvTCqLExsVKOaaHhF2KF5/3nGfceSbEq4JCnUYOa4kdsX8KyynkazeAedml6WKUdBS13cWaG4VNCqo3Zsvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199262; c=relaxed/simple;
	bh=2i6N6qh/msJleITW5KtvEsghxGO6V0Ftn3+H2o93hHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u7m5fkNuypWpAxK0Kcy3hvahO/yPrWcV3/WLMBO/uFvy8wRT2AKstdLgMG43evB9PNgUSrxEVV6ucDFvyFXt56j+j4mwuyQXrxd5GLXomQ1BYh1FSpZamNTZ1/h98bVPL0pVIghxsCRg9FZfmH2dNID0oim2eDFtOtycPH0HUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gIlFzduk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43943bd1409so11231785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742199259; x=1742804059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=83LRd2D7O4aPaXbe7SLzDO/v/FcEjfxehVssmnmf1cc=;
        b=gIlFzdukby7Coy2nSZM0spajJk6ao4r4uZ5byHlgJIqrRV/g6lseEg9GbLyG2MQ9Uj
         ThQAMF5oVF40sw8J/Ta8w+YJW0RfBBYgHh4zGkEEY6FsX2lhGfe+UCAQEVsLFrn7AwLM
         LXB8mO0PJovvYzw/wY+M84mof9W0IbDWbbGHwgRTrLutedECMQGzQT+TpqqxXkwTOc82
         TwNjYsFplmGZND+tdrW7AaRQzSpFBbCpuKk5JIf3kl4zuBYTMxuKnPFhHhc+KK5tfHZK
         r0mF3owg1GDmrO6a9zX+0qxZ7mz15w35wWFGHdHNri3L5R9FxqPGVzjKPZ+zttyxwYWJ
         ke4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742199259; x=1742804059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83LRd2D7O4aPaXbe7SLzDO/v/FcEjfxehVssmnmf1cc=;
        b=unwTqDPXIdRmUX6GfzM6km67Fay4VUKgYqzh5FH6kjHJzjyzAWxIWlT3t+26gVE7tU
         L60ZIrSGiEqZfT/tZ+qJnGgJzdVy0mo2bWRjAOcQWy6Y9Rtv5dmL5s9z/TIXaFW9rls7
         WRaLuyJQaL5s1jNVQ1WvrS4/Ll6riTDHlYwq1Z+oOLK8WYxtg2yRmO5n34eZXY6P9UaZ
         iMpDUQrS8IScziq8CWDQBZAiRaklB+MfwS1LGJiWcAQ+u3W2YqxKg2WlN7oJbvh2u5xT
         PhsQpDrCdTdw8s1sEyQfwBl87Gn3yqclFuW9HMj8XWbCGa8UHUvMMHzgZwXW3nrr1w79
         rwSw==
X-Forwarded-Encrypted: i=1; AJvYcCWFVumynWYM9KIU3nw4vNTl9NKtiihZoyqDeN4mpT/E6Qg9iJVxp8ee1YmXuALZk9HyH/F9VforLCohO9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITHyTdGOBVx6oqMfJ1nLcS/hrGIu9CLelDik3YslJWQp7o7q0
	BnxBBMffdWLqnJgKCtsvPrEfEc0Qtq1cuMzsWW5nlISRRO/LyxmnbF83q17B8L2rzStnCiGM8Or
	/59JhuWo4Wg==
X-Google-Smtp-Source: AGHT+IEqBcGiAda1BI1clW6uHjtQzyiydXly9ZwYFDpiuv8DsK6aGpLh0H7vB939t6k82mhgdTxYibw7X1kEBA==
X-Received: from wmbbe9.prod.google.com ([2002:a05:600c:1e89:b0:43d:b71:a576])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3592:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-43d1ec72a85mr108929545e9.6.1742199259183;
 Mon, 17 Mar 2025 01:14:19 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:14:16 +0000
In-Reply-To: <2025022658-CVE-2022-49444-ff21@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025022658-CVE-2022-49444-ff21@gregkh>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317081416.377784-1-jackmanb@google.com>
Subject: Re: CVE-2022-49444: module: fix [e_shstrndx].sh_size=0 OOB access
From: Brendan Jackman <jackmanb@google.com>
To: gregkh@linuxfoundation.org
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It is trivial to craft a module to trigger OOB access in this line:

Requires loading a crafted module?  I don't think there's any coherent threat
model where this is a vuln. Probably a CVE to revoke?

Unless there's some detail I'm not aware of, e.g. this bit of the module isn't
signed or something.

Cheers,
Brendan

