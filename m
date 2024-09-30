Return-Path: <linux-kernel+bounces-344509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9F98AA96
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EFE288BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC0194080;
	Mon, 30 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AF5JwnyZ"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5F193418
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715894; cv=none; b=i3pB7c/MMVcxtwyanvUAFKommtf4NI9pHUO2h9pSkF887Vfa/X6W42BOsTHp0855ojB/HstOg7aIaNsOB+2wyQjX+5+mCkrbzeNQw+//Hs02MP8H3dU8vndFgbK/A3nSFNjhNjPFn55iI55DEaRtG4a317FPJeC+8bSCbSVP5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715894; c=relaxed/simple;
	bh=DsFjvp6V0bUt3fQrlC3zZfx5v7AY6PiaWkupBsGfwY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRGHP/0IqzV8odfhbJGidMDtL/aCm3MrOjT9A8NCK/iEHBjNO1hogqU+eTLl1uT4xbbO59OQx1bUF41999J7q9KYCsAjo9gR/m762s97chk8qdsOh1n0KDffPK2AK8DgYfabrvCqhyI2fOj8d4ntUQxL9Ix8xlhZvW3KsC7l1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AF5JwnyZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71970655611so4299686b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727715891; x=1728320691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xz+bkfejvthPlgPdQSvVCfDsoTn99Xm9hmAjc8LPyr4=;
        b=AF5JwnyZEVz27AkN3p7pLqlTxziQ0D9gti9i0xwRA56sfE00p2KLl4Bg50fRFG627e
         /e9wPXVkGHYBEe4RMiyt/H0GFqHlXrD/wIA7oCNUHv6V3/YF7HWZTHRJq/ATePIV3wat
         BuOMV3qYDVJO7M1LxfnBhP0C3KzVY2ZnHTHPbiFv+3dsQs6c+xovgtZc+nBJaRDQmw7r
         IA3Z0wY2QbuR/smOalu9YSzz/8DVGN3AjcMIyPd13eWJxJZbwx4CP0VYjepzafUZa9DF
         pSgBcbQmshGRHGQJk0WSs1OqX/lbIw7P482GvWkzZNkPCpdh94GhPsg8yH+orLS/yqHI
         I6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715891; x=1728320691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xz+bkfejvthPlgPdQSvVCfDsoTn99Xm9hmAjc8LPyr4=;
        b=VSWyFy1rVIYcCXSxka+RG8HF4VSoMNv8nH4DWHCxaHsDNs2kx/7yRq3c7FZPhtZwTv
         Ioi5voNzfzbUt2om6mzYGmmOP8SDsdwKk6Lq1ZNgY0I6jnGcFt9PILXf9315TUYEmPsi
         QAkJUvLrl50q17glJIEER4VwiCD7GyQ3TxvlvQqiw7seXGqBHkU0i2/tWApLYFk5d2c8
         cfKGuVz6n9lshXPqG6q0Zdd0D8HxWm6VOH2C35Joy6+5omW1ewAzkyL7qEeUwzxyOQuG
         XoTAopvxpNnGIOe170tUPXUgT3zeARxcRzQNo8+HnhWS3x2uruz4uV+hnp2QfMqxaXXr
         Z+mg==
X-Forwarded-Encrypted: i=1; AJvYcCXNiv2IfTmxWyxi6yyb5qYKXPc/I974vcVmzTg0n+dJyQXFfSt/mCXkEV7rkypewVfzlVeuOF7kLBWijXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwICQW4wg1yDqHqGRznQwLiyMz1TPdLY6mdIYq+ty66QFYf7Wdf
	GcJGKwV2EFyX4wq74JdAp/CSEzGhekFGU6K0cInxl+UCKbzgTethdCqhThW22ew=
X-Google-Smtp-Source: AGHT+IGj3wqkwReKg8OnHSxdCc7zaYOfFfaOE8qXpsQ0EjTy/gbYQvbdblFQ+sQxStUGKpCkov+09g==
X-Received: by 2002:a05:6a00:4fc4:b0:717:950e:b589 with SMTP id d2e1a72fcca58-71b26049452mr18911436b3a.19.1727715891519;
        Mon, 30 Sep 2024 10:04:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2cadcdsm6784562a12.56.2024.09.30.10.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:04:51 -0700 (PDT)
Date: Mon, 30 Sep 2024 10:04:49 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH RFC v2 1/3] dt-bindings: riscv: Add Svukte entry
Message-ID: <ZvraMdZa8Shs/yyQ@debug.ba.rivosinc.com>
References: <20240927-dev-maxh-svukte-rebase-2-v2-0-9afe57c33aee@sifive.com>
 <20240927-dev-maxh-svukte-rebase-2-v2-1-9afe57c33aee@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240927-dev-maxh-svukte-rebase-2-v2-1-9afe57c33aee@sifive.com>

On Fri, Sep 27, 2024 at 09:41:43PM +0800, Max Hsu wrote:
>Add an entry for the Svukte extension to the riscv,isa-extensions
>property.
>
>Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>Signed-off-by: Max Hsu <max.hsu@sifive.com>
>---
> Documentation/devicetree/bindings/riscv/extensions.yaml | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>index 2cf2026cff574d39793157418a4d4211df87315f..9f730e3aaae949debc18396183b989b504dcb899 100644
>--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>@@ -171,6 +171,15 @@ properties:
>             memory types as ratified in the 20191213 version of the privileged
>             ISA specification.
>
>+        - const: svukte
>+          description:
>+            The standard Svukte supervisor-level extensions for making user-mode
>+            accesses to supervisor memory raise page faults in constant time,
>+            mitigating attacks that attempt to discover the supervisor
>+            software's address-space layout. Currently under review as Pull
>+            Request number 1564 at commit 81dc9277 ("Svukte v0.3") of
>+            riscv-isa-manual.

Reviewed-by: Deepak Gupta <debug@rivosinc.com>

>+
>         - const: svvptc
>           description:
>             The standard Svvptc supervisor-level extension for
>
>-- 
>2.43.2
>
>

