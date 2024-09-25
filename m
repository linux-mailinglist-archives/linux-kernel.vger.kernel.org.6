Return-Path: <linux-kernel+bounces-339269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB1A9861EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812891C26D90
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A685617DFFA;
	Wed, 25 Sep 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SjU+PFdw"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A317DFE3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275692; cv=none; b=HzmMPvo6RCYtMm6w5bqCGnULnfc/SEbK3qB9/4guZMgdYPZYbPPmPyfYiLZ5tXukGxeWsV0dCWzexHjQii9rZSyK0PgJuhfnwyXju0RJcmoQhuy7xecJ/lEsRPE1wmCrGsbqRbMC2MvkSAduU0J5GH69jWHB8UXieG1CTjQKj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275692; c=relaxed/simple;
	bh=ZfyBcDGv2ZvaU+gCpRHgZ2PagwSzXnWPp11RYk5AnOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwoxN4gexoE7q121K45uMAqnSmx31FvzN/up3og2kVd/HpDs29F0PmNqnayhOUfAyIOkKgKwdM4qGUFSnYEmfreRLftOiDd8N/Ud7gNOhFCb1yerZxFS6gSpYEe1f8+8yqmiRGS/rn9Qx8EYjEgEd0Dn5+NABr2HE8nZVCZnqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SjU+PFdw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso709096866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727275688; x=1727880488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfyBcDGv2ZvaU+gCpRHgZ2PagwSzXnWPp11RYk5AnOc=;
        b=SjU+PFdwGIHlI/vtoRt2UvBbL/qq68jnl03Y8sNEVsfXZ/hKMfM0WEpUqR3oNn0y49
         d5OyHFjn4enf3W+iE68YSvSyXX9kA1ngqrF/2QTi6XItOF7LVmCP03AmRCs9jk0PkYyy
         3/LzGxbH1u044J7DZDNRQmtqwoencjaBfUW+pU08CeJx12wld77WZn0KMRYJV5r0A8A8
         s+ZkzD9UpXoKtzG3X7zPmW0yHO+7HpKwdmcgYjQ5rFQPaj6kke/cYhAR2FIaQsXz1ZYi
         hSbFd1GUfu1ZAwNgekHCJT229mzYCE8cstBd2qUJcTevn/cHVTbCBJwfwYTQuOCCKEjX
         AqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727275688; x=1727880488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfyBcDGv2ZvaU+gCpRHgZ2PagwSzXnWPp11RYk5AnOc=;
        b=ApELEPpdYo0zpF/Y2ZBgEbGQ8nn8YI1g8970EEN4V+eNebu9k5u9TSp92JxPsmkZhN
         AtwE0UDVTLBct6/Yvjj2EBmTAfAIvyhX9AvQ8cVbMt7Xg8SpWi38SZ3/4xzAJdW8nBNi
         kfMPiwYfQgfzl9AovyQqv9rSuydsT2N7j40CNoNqhX4EAVCdoboQvE/Lv8umAxgRz5fx
         MuiRT702mQDbtk1x13rZKMqeIyMjl0GJal+ub+R0P2WHpsImI8i4Jt2vl278Pxc8U4w3
         2CbDYvBCISIrd9JaPkr141o3Mn9spYNuSj40PpWvYkS1H4Rh/LlUmVAgJkYo4WA7HQge
         398Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo+BLjX36ZJYkzRxmnErHPdiXjDGXnVWHlGysRetGcAX/BEPD9Ek7Pt+Tu/ixOGXRPyhcxsVzNdxPl+9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYjGfZU2Db/9LR+1XJGiiKZdHM+5oTVeiyjt1vEyio/apm0xp
	Rj8zlr48sPMlGvzxZRHPsuXKPUc5nETFVNiECcX03QSbgdPPdnspdHwLeecATSh3NrwqG/6GLd7
	RHVUQTnElISICNX2deT8pLKAWjbpZ8KpZxBY85g==
X-Google-Smtp-Source: AGHT+IH9j/JX+iBbn22xiqIB/wV8Wbu13blKCn896GHhaJCrEb2BGvwE5HBNntXMQ3VhE//CXwPTCMbWKAAnjo/V3hU=
X-Received: by 2002:a17:907:7ea8:b0:a8b:2604:1da3 with SMTP id
 a640c23a62f3a-a93a037583bmr325593066b.17.1727275688066; Wed, 25 Sep 2024
 07:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925142532.31808-1-namcao@linutronix.de>
In-Reply-To: <20240925142532.31808-1-namcao@linutronix.de>
From: Evan Green <evan@rivosinc.com>
Date: Wed, 25 Sep 2024 07:47:32 -0700
Message-ID: <CALs-HssQ=ytHT6ZBfO_qNDGTepzQGUVEygCPReb=JeWVkzsQ8w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: riscv: Fix typo MIMPLID -> MIMPID
To: Nam Cao <namcao@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 7:26=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> The macro that is really defined is RISCV_HWPROBE_KEY_MIMPID, not
> RISCV_HWPROBE_KEY_MIMPLID (difference is the 'L').
>
> Also, the riscv privileged specification names the register "mimpid", not
> "mimplid".
>
> Correct these typos.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Evan Green <evan@rivosinc.com>

