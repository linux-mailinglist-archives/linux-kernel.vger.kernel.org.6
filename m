Return-Path: <linux-kernel+bounces-518546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17355A390C1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E6217A0F91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761811487E1;
	Tue, 18 Feb 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEpM9EFG"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A30D145FE0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739844737; cv=none; b=ropXQsMOYeUReOYnOl8wtHOK9JVcfo8lQOxKzcoDi3pM4okNKKo7TT6HFm0dDQ5ncHKTDYgp7yo7Wm5KXDUg+txtKvsqoq/oAC93s8aeYZHuZ09KC2CIj+DXbYeFP08cpQaO/NKRfxFcIAVYIX/Jay3ut3oOH4xourw23hSsySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739844737; c=relaxed/simple;
	bh=fjBYlxbE1h/DOuOc31KToTPqxmYA7HMncRPrxjXgLg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLVNZnS1Se/OrXW5n0B56rgQBv8onVZ9fkGSIW+wJKoVARd+ucCEazpLk+cvB3uV3Q+M4W+bza/r12KCjAeUKx7gbHwik/WLVRkXdvIMZRucHidYXPctVv95hv0HaEgfbxanr9ClnayzjTGiKuNn6dljb4y5ZlOOphf0S0xIa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEpM9EFG; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e66a7e2754so24167946d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739844735; x=1740449535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFj7UXaCbYXWJKfATJnfF3oNg/3GMNWA/XopD15wK6g=;
        b=fEpM9EFGOPF4pQebTxR0PiY6UMv962EaZkMwsSIICuVAzWqZD3NAqPweCGbKNnhpLF
         zvvCxdEpNj4yWR+pp5cZzoh3eN4kKaxvdBlsd6Ec7zDeQR5CtmpgobRaFV3gb28xMbge
         UKQzoEhqnVlSHXgzFbvda3qfLc5YA3uSAKE9zRg7HTZ0lCTf+Gs3JbZ+dIyc1qnSkepO
         q+LRZsxn1wj4iu1pTG/REZLPKutVT7sEgQoAIxzPekbjdjpMTEr33NwP0AjXj8A7o9F5
         hEjdjeI5dd9OlDNls2+YoYY6hSeaiq/T4AH9xr8cm9GzTsNXCuo7nje45zvNRlO02POt
         1ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739844735; x=1740449535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFj7UXaCbYXWJKfATJnfF3oNg/3GMNWA/XopD15wK6g=;
        b=G4RbRC3Hq/W+NSbIgIJIPpivEWG/hERNh6HcTr/dUhkEIqZYbuwil3fIdjHQmfQXTa
         zHIHOlnZ2a0XQqUPZ0MNgPvj20tkdfd19toEZNrVy2JOoNBfOzS0pKVrU7Fo0FXVcZ2F
         Zeqmoe2WlfF0b457Q5OedfkrfgPrqe0/6UAgnPgP2MkXwEDppHIeL7eDMNhA7aK/w0pU
         fNRV8mt+UTEdZwaqM0tMXsKKrHE7D2V+2Sc3nVAx64626XE4PJIv/QIaMaxulj29l/Xf
         QtpcN5E24ZNfxeBfWJBuUr6x97cHhJZ6GM/SjjyTzCnUXD2k6A6pWIinmCMxj/7pd8/K
         UTDA==
X-Gm-Message-State: AOJu0Yy+8GcM3cCSxME/e49+ZyU7ER/uCJhFU5ZZMZ75EJG1MbicA6pf
	pPQPpnTpFZ8MeqJzrvpSzos113MZ1YW/QwfgWINU1gOg797udWLR
X-Gm-Gg: ASbGncvbaeXaex5qxme8T183SjEJojUo4a/417t7ewY/pKTuTTQxD2I92Gwez/WVLZE
	z+UfuhJk1LxHx5SZxkSlBOJXZLOvVwAnkxhlUftvwkhU49LInOh2KljZWv8ju+djxg1NdYnehrl
	yRsYy7EZHn71Z6ZfX+mAeLbKsv53ao96PD9ld0hlu8PBICdpr3S9qrn8GKVBJBEAHxcpSJoZzNp
	xCudd+sCenhs1YeStKgc05/l7S42hnR+lNCjr970SMoyPRHA9aJUj4l26keqX4OjlE=
X-Google-Smtp-Source: AGHT+IG6GhKW9alG2L/dAhy8Vk9gV9ZNg2jhx1jhDY57Z65ue1+h3rnzF/NdR78ODmApaHhRn3CMHw==
X-Received: by 2002:a05:6214:1bcb:b0:6e6:6504:ea64 with SMTP id 6a1803df08f44-6e66ccab3c8mr159240376d6.11.1739844735358;
        Mon, 17 Feb 2025 18:12:15 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e672c1e7f0sm29033026d6.114.2025.02.17.18.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 18:12:14 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update info for SOPHGO DEVICETREES and DRIVERS
Date: Tue, 18 Feb 2025 10:12:00 +0800
Message-ID: <173984471557.305421.11394944011706782554.b4-ty@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212022831.244143-1-inochiama@gmail.com>
References: <20250212022831.244143-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 12 Feb 2025 10:28:30 +0800, Inochi Amaoto wrote:
> Add mail list and wiki info for SOPHGO entry. Also change Inochi's
> email as the old one can not be accessed.
> 
> 

Applied to for-next, thanks!

[1/1] MAINTAINERS: update info for SOPHGO DEVICETREES and DRIVERS
      https://github.com/sophgo/linux/commit/8630ed6f2adc2dcc89ac601d27c3fe37a187dfec

Thanks,
Inochi


