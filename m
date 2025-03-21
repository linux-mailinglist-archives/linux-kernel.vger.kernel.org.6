Return-Path: <linux-kernel+bounces-571379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A11A6BC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291923B855E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01914AD2D;
	Fri, 21 Mar 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hCWJY4H/"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDA757EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565591; cv=none; b=AXXcIDhIMQCp3awX8vwGaSZCPDSKp+xPfseY84GixhFkDnVkV2/56t7X61ZHw//f4uv7xtwNamhpAPGv/qxVjzFWpy/diTV9pxELE9i0DLjyrWXo5z8oWUFdL4BVLPWJHbkQbOBHrPDATGxkZB+iJM9xesEzE0Pf2ubspV1dwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565591; c=relaxed/simple;
	bh=HqRt79DUsL4J+Cje/U08ihks64TvmbBB60ER7m4KqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UunROprxDewpJDcfniOuUc4Ty0BJkGFte/Gc5b7w5tu5684G1W9Dr4m1XT1/m9oa99TdkukhEbrtL3uudFEHkxie/98PD7ywYMZDNdFQolOALlLE6APDrmu4gawh5pQ952KvdM5xUbRbJDvodySXBS/Q8ADBBFGUtJPIHWoVwxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hCWJY4H/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47692b9d059so27207241cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742565587; x=1743170387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9dAeMLXO1UL2jebDZiJp6MgSYhpvl7GGhlGkzkHYBE=;
        b=hCWJY4H/HvCvnT1jLdtUK2ei//S4FKzJ86TrxA+ffD7axcaxJ8tsd+5Qm83KmnsBSW
         Usm77Egw5Ca975GFTLgsm96hanNsvwwcf4C4bwXBQO4Sr+vRUpDD9H2kvQ9xN6gc3oxI
         zQ3LmuBXFBAej+pvIU4/d9Q7sTpYw+NJCldr/JI5iTxK20T+a26I+LIIQ8QYB5vmJ3z/
         Gv7iUWS58K0ZjwsLZ8DXmxrd0le4j2Fkajuxt/opVMzX1QyZW3CBBevVAVL6xyePNTTK
         yFULwQSy/CtFmc/rA92vKZ0NLorkJSvMDYr5dt5VvG0tMeZxtzZQ8R/Ia1k2g9MtAn+G
         yk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565587; x=1743170387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9dAeMLXO1UL2jebDZiJp6MgSYhpvl7GGhlGkzkHYBE=;
        b=VScId0fNJJROfXnS4z+Qz4Qb0VteDYjSJTe27qEyXJuI93DY7HjrIESO1g3F6fNdwm
         LG0n/XzTmiBJqYdayLVgGcWc3NhmHs1rcbDgC4+ilR0tWFb2hlfIGTU3jxS+wTHkaNak
         jWNCbMGJdaFJPivkwEH3U6iY0TyJRdrwPz3Kl36WqFlvft4WfR5AorAzxappgpSsDkyH
         HPF1lum4a4O6gppQn3Zz6OCNKBMtRw3AxPWg5QdkZrXavscLukDkz/OKrZ3IyFxvZPn2
         x8i84Xko5/XIWWUk8jNyj7PzQ6CSkV74os1H2WZloAwsY7lJOLaE8JnKbdMj5YzbDm/S
         VYww==
X-Forwarded-Encrypted: i=1; AJvYcCUBAXiS+wcogFYSPxjsI5Aa7UOnVfu4ejzDrhnhQkBxAnY/EWPNWrnoHzyLU8ZaOp39xTaCHvct72cqIzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPSbw0k5QMxBkzq6E2KoJ9oOxrVWvC2Y13Ukl7wCZSqIyV+rk
	0EsxqTW7lZq5sIWHqlUmtFbOBGuEYsEpkFcKaf7tDRwI05Z2c7uWfBBa40Nnn9M=
X-Gm-Gg: ASbGncvQKWFUvaJSrsddcBvzYHBVs2+Mg4VGhlSiLQiHQJUkCQaHPvuxA2PkA0JQXXK
	x3Y2o97hwH9f5pgiTi9/+TOVmiMCRyrQhYsfWbS9EWORxDjojZI5BO13VllP+P2af3lyndkdvQC
	S3XNwGYfZrBUjuqBbnBr5R+iOHchiBxwZGrNBfw73M8og0Flr6mA7VPvGL6r/d7WVSfqE6wDbeO
	vLUSl++306N2437lvhs8+ciSRv+mW4r16qSDr0fORY/QtKd1Z25Relg9VJdX6Zw9YRZaIPa9dBK
	++LFDArSPZ2/nLhXZFlc0kF8OlyKWh/oOm7Bchl7mNtTNpi3S5f6M/AnxThDdQ8yFS+GYqctPii
	bU4DyCv+iUOSpPhy/geles1YigbE=
X-Google-Smtp-Source: AGHT+IE40rw76FodwmzMUd5ZJ5Utk+psc3XwsJk0EM0cBH/ak9gdBIcEuV42/YBp1/X9s3GgwHKeSQ==
X-Received: by 2002:a05:622a:1148:b0:476:b783:aae8 with SMTP id d75a77b69052e-4771ddc9124mr46926961cf.26.1742565587375;
        Fri, 21 Mar 2025 06:59:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f7d4sm12292181cf.37.2025.03.21.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:59:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:59:44 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z91w0FQ_CeWCHZRF@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-2-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320041749.881-2-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 01:17:46PM +0900, Rakie Kim wrote:
> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with `kobject_put()`, ensuring proper cleanup and preventing
> memory leaks.
> 
> By correctly using `kobject_put()`, the release function now
> properly deallocates memory without causing resource leaks,
> thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


