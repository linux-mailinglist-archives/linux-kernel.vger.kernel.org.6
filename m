Return-Path: <linux-kernel+bounces-569332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F7A6A18F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C96884289
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CA421420B;
	Thu, 20 Mar 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9YSdxbt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1020B7F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459933; cv=none; b=keVDmRGNrwqtwLhsmrb/qLebYZawVhnsXINTl2c5vN2AlgFjv6vV7vqfqUVYeY6k0tQu3Izg7+c9hrZnXhaKWRK/EJZ/vuhRrbph/xZll0qfgYSXKXp4YiwBQsFQB7XhX7c0h2kdbKYIgHKdadYkouMH4veCPHuQ+vaLxwkpAXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459933; c=relaxed/simple;
	bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vn2SXvH3O5l1I1LQLMwhz7loP/+LpWDkST4is4H9efUnnLFgz/ejMBdhQdajItz/25zpD5nyRXSrz4945ahohplV5EvJ51PNgyhL4c8P0n9PTCPmdqTmHFHvWjw5TRWBmsUooBHHJi+lgUCJzpII+utFy/X9sMhXIadlbrcEtvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9YSdxbt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54954fa61c9so738241e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742459930; x=1743064730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
        b=J9YSdxbtHHUXIMaW8mrL0B3EeZIhVYTY8JbFpyFB9nk6ovBFGenKhl/Pi/5g42DD36
         rZ02aUr3nLTw85a6hy5rp5VxTJQDZ3/6ve6ezDSURsOK46kViehK4vFBQt+TSPa/5Bkw
         V9kls1s1tOy5aXj94BZ4SjPdvUmhZhM2qNuk73dnQ8enUyopwmBazqyUauyROA9XEOsq
         PGkBSBXHECboTJRiu7yDIJFqbxL+SAhqqOPtwDRatvKe/g5GVBSCinETGkWhK1ZHeDRt
         rNrk35eqxRYLIvciqBtDc+07I2fuB53INXz5ImhN4zKbvx/Lev/nEvWCR334md91PWSH
         kPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459930; x=1743064730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hjnm6h6VbKdAmP+BYdeTLnUhxywAbAPx3ODECnQc050=;
        b=QM7i+fGxA7kfazEjU1uzyt3c9GL87DfjDoYKTT70pZbcsGz7nOw4xs3e6We1QH0Osq
         owS0h0jaeITdfO7BMghZyiLIGnIlKXIN05thS10rR04FjT3gdaZYFCqUYxaFmoSDVo1g
         8yFsmjiEM3YtO74JzY51H7WDo7Ct/l5hphfOJvwDPGBPgxKZfOcKsXMx957Ny2kbu+ms
         hc4ffTt4nOYqeCqrOzwYq8db2U3faSde1azaDGz3a3QqM2KrgjrzDeyt8uFWOnZ9kSWN
         4bpCO6GC4gwRo+K+lQS+trpp0UbnUNOIHC66A2qJYFDpn8ClGibpPwQruGzGhHFl0wou
         6UPw==
X-Forwarded-Encrypted: i=1; AJvYcCWWxniuuX8RQC4IghakcI3Vqf4oGn5qRMv5hSFwD4wnVMZB6Ue+G+3Ji6UXTYqUe7G0O60JYe9yBZvkj+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCeL+N9IDtqW8/Gymb2i76R49VvtlI0fYcvzgYXZyJPlSdlSg
	ue+uzOgsHM77Jkj6k9VOgD8Pq5VNcy1qE5Kc0P2fFA0Ud6pOz5bgRJB6XagbMLZjem1OLOO9tn7
	k/OKAMUmPY5srPujoKeuWqtjrfEe6+ZtQGszf7A==
X-Gm-Gg: ASbGnctmr9LHvjsQKbhHD3J7R/GEw42nTJHwhECCH8wdMWS905LxKqY4G9Uao7iKsWV
	Ai4/O/X1YpSXUGU7btYiQxLe0tewUZaIK7W0UthVI7hS5PPgyozOWCLtb7xwLrij6QIDuP8fBh/
	Mb5k1wC5MWnzPxDwdTAgZd1Co=
X-Google-Smtp-Source: AGHT+IFD4w4hNXYvruLDdSQP6C1+rIqqCVvC3QD11WfLjDdRrOARbFWNTEqGlnQSTwkwpoQx+WoFOIViXCqCm2xtkIg=
X-Received: by 2002:a05:6512:1255:b0:545:2fa9:8cf5 with SMTP id
 2adb3069b0e04-54acb22df99mr2287327e87.49.1742459929900; Thu, 20 Mar 2025
 01:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-48-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-48-jirislaby@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:38:59 +0100
X-Gm-Features: AQ5f1JoIspSXlQN4dIKbOu1jN3twH_3GYAyvghW85Pzo3hZCWpBv2464HnjyEHk
Message-ID: <CACRpkdbJ-SryFs=dhjJMtUXRP8LLOyu4wYVcu3T--OwagQx_Cg@mail.gmail.com>
Subject: Re: [PATCH v2 47/57] irqdomain: pinctrl: Switch to irq_find_mapping()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:33=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:

> irq_linear_revmap() is deprecated, so remove all its uses and supersede
> them by an identical call to irq_find_mapping().
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

