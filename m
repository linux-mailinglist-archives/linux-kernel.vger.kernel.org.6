Return-Path: <linux-kernel+bounces-387550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D459B52C0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EB8B22FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930712076A8;
	Tue, 29 Oct 2024 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RnIs3Kpn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8820720C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230227; cv=none; b=Znu27KCVPMKVrdpcOCnDXa9W3KQ0IPnhC106WHBavovcfQaIwPh81lD0aYRoCf0bM8CoJdD1p/fTjujM88c2osgg5qI6Uc1PaQuaI6FEqT1gh0CWi5Gfn+Bkyt4DVTyN4FsakF+Z7RFNZoMNeOC1DbiyUFx9exC9anXvQKPCMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230227; c=relaxed/simple;
	bh=UZqxfxGhhDijKNFqX9Nf1gDfRDmnMbrN717VYuDwDKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnGLAn7jnOhVJDV8n28BrOh0UyJECY9kCk6TDRo4xz+PdeYDd0tatJcNzmDiAqFk4Zv9XIMgP9IMC6M2deNPwoTNKdQqArFkwy1p0Rwxjd9H6oJ/kPu6KeYbfJyr7eOVWVWBUMTQ7pKqzojfBQT9d6sPBFe3ZVDBT1LhIvZ2GTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RnIs3Kpn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbcd71012so62856125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730230224; x=1730835024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eZYty5iLNq618ev8kgFv2jOkN8cQs9inuPb0s+iDRZs=;
        b=RnIs3KpnhAhdaw72QWOHsnDArY1U4ueQHuO698SmE7CIddokHXSanrLxlUPwA7K3b5
         hhGVnXa5InCXF+yUktBVby5G2IZI4tw+9kPOPBZstkm4pHn4aUqlL1/+shG2gY7jQRpx
         PIG3SukBmxhJySX8zXHWC/s7pEumpfHSuFiPaUGDVXCzgprtdBJSIYZvv9pKRS/gqoSh
         YndAjPvvwNeqPCeiSFy7FdDZPAeBuSTC70jlka1+Ja6pOPSXz+LDRauK1Nqxxa0JC0RR
         1N96xOHO42loWAiwTAeLiQtyOucJI3uFwN32FpDmOnoYNFk5BRUEMxXwXPdYErPkoDVQ
         JUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230224; x=1730835024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZYty5iLNq618ev8kgFv2jOkN8cQs9inuPb0s+iDRZs=;
        b=e2rW/GIMdA0VMc4dXE1V7ORjOIboxoqPweIe6yBBZYHW6/v9vZRyXWNFP+knr4o3hZ
         qJfi4S6piTL8I7NcunseC3sL8D4uO1q9jOamdVPHaq1n5SDwnIQKwBl4cEeBAxD9VkrS
         KFh/9m9pIHb8syBNwcUfkVb7t/gUF/MHWdPt3YJKagqo8jhVSJ7szvV8qBiF+cBt2iDL
         aDBhgC025l+NEokgA62cWnpMRYYz8sNgcNdWZtUhWmKKOzuZask02yOcLFCy4Ly7m4Yn
         TjYvHH96KVXupN8bdg7Xn7/fjQ2ZpQMyheKypteNcltjiqhvclV/rqmloK8HuyEAyr3M
         RYOg==
X-Forwarded-Encrypted: i=1; AJvYcCU7t5kxxU4uVgfBExfp3ajOrQ8KKQRTm8l58HM3oWy0x9oEywNFihR+qpKtK6XD916TB+yU1s8lYclb63w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+eC5jWBNk9WGzA7hFREUMhKHY7e9Byfxsn3tgdinhnAIMLlz
	cTSVtO8A6Uhd1gCw+7zrgn+rMAw38H7PGieHHXkjblYdwT3H36jcC21mxBk3yII=
X-Google-Smtp-Source: AGHT+IFCGTXJ0m+b8aQG2NJq1Sf6l4nGmP7i3RBj87u6UaZGMbHBTkMdEXBC+/iHz1GLrMqpotUaBw==
X-Received: by 2002:a17:902:f70f:b0:20e:57c8:6abd with SMTP id d9443c01a7336-210c6c95ac5mr165995575ad.52.1730230224422;
        Tue, 29 Oct 2024 12:30:24 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf88490sm69587645ad.114.2024.10.29.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:30:24 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:30:21 -0700
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
Subject: Re: [PATCH RFC 1/3] dt-bindings: riscv: Add Svukte entry
Message-ID: <ZyE3zSNnc9qxUPly@debug.ba.rivosinc.com>
References: <20240920-dev-maxh-svukte-rebase-v1-0-7864a88a62bd@sifive.com>
 <20240920-dev-maxh-svukte-rebase-v1-1-7864a88a62bd@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240920-dev-maxh-svukte-rebase-v1-1-7864a88a62bd@sifive.com>

On Fri, Sep 20, 2024 at 03:39:03PM +0800, Max Hsu wrote:
>Add an entry for the Svukte extension to the riscv,isa-extensions
>property.
>
>Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
>Signed-off-by: Max Hsu <max.hsu@sifive.com>
>---
> Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>index a06dbc6b4928958704855c8993291b036e3d1a63..df96aea5e53a70b0cb8905332464a42a264e56e6 100644
>--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>@@ -171,6 +171,13 @@ properties:
>             memory types as ratified in the 20191213 version of the privileged
>             ISA specification.
>
>+        - const: svukte
>+          description:
>+            The standard Svukte supervisor-level extensions for making user-mode
>+            accesses to supervisor memory raise page faults in constant time,
>+            mitigating attacks that attempt to discover the supervisor
>+            software's address-space layout, as PR#1564 of riscv-isa-manual.
>+


Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>
>

