Return-Path: <linux-kernel+bounces-319350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8508C96FB78
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE31F230DD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA462155C98;
	Fri,  6 Sep 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="hpmgpssp"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61C1B85CA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648486; cv=none; b=V49f348FdOpLhO6cN/MyT6grtWjz1QJ6fJ0OnwHA8EWy+SR0QsmCS0NuhbLJ/viYr/EgwpqgXt5V6tDnrUUFWX5+Kyu4tvsazT1G2wXRDjuRZaFWRGky6jUvvUJLBGkBByeWyoiRWh3mNhR5QloJF8Jtl2W7w4ba0WFSP3hMpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648486; c=relaxed/simple;
	bh=j7wQ7kiUy9PPGbTctIoCqL7je+xOYP7ksvdEFQzeHNc=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=etjsCx3eFKhUl8uEVcr2s3KU1Xw8spZaK3OzKW2MnziZj+VvRbdpJYc5I5YUiJs+v+2bqVl1MBotLJF06PmN3sh6fErrMTjIAUCMyObtHgKSuvnJ/8Pl4I38eEl6KUGW7YixZ0ozXGruYoxSvHBYC63P57fGuq3NPyPK/5zq7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=hpmgpssp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso1813483a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1725648484; x=1726253284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDfjnNTuhJ1M2Y8qERtlchXQOcy0y5eMF9qJKZkx/Vg=;
        b=hpmgpsspbO1pZFSNRA0IZ22KWbYqbBSrZAXUTTuD7YD3LZs3FZm2iBKbP0FpBRjmCu
         Sdgs3Zy4lpCk1w4FeJSRUVGmQ11E7myPQUpSHsGdjW7yV/fA8ffo+m/gOcLg2hEM9DJ2
         pY+zXjy36/emSzvSlf9rYeMVngO+31he7r03J+V+zukA4X+FLITOuKCETw+NEWkO0Es8
         GSyR/BYrArZMITTcbsgp33rBbK8EwXJlkMTTcPLBPEyyGUApn+eQ3d41XSxXydWqCItj
         yzURpa0yJmeOLTysOGvRWordcyBYRzwgwBX+9jhPDGcGNNgGn3P+o11RTeY1feT4NpF9
         ie/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725648484; x=1726253284;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDfjnNTuhJ1M2Y8qERtlchXQOcy0y5eMF9qJKZkx/Vg=;
        b=EwYLXAbyXWmddt05vTcKo+yACISQBukK/NrJ2IbSQRsmI/6frIyisYk9UiE+meftfL
         RKJv5IBln5xO6eioN7GkgfLTGIV+hVryELhYMhnDB5inzSW7GRcwlGf7057EvzNt11P8
         HK1yvRUKTXdyM10CtsX5MWTzeoHly6AlDe24fgIc8rzgwvhK2FTtqi6idWnpU19EWDDh
         bUzzd9hiwSYbyDCILiucOdo3AICNnlLal+7Rrj38ECqQt9/SAD4m27bniyuUE2EGQFhA
         iEvRec1O81qN/dUZpGLA03rtTAa99OSS2yfZp43+BX27SWCzB5mBQWdGGjp/hr944HNm
         1DaA==
X-Forwarded-Encrypted: i=1; AJvYcCULFdJdZ3c9NdLY5amfsCacmV9+oWzevn2dJxtZ/YjPR0V9RtQBGrooEvPYDSWeG8YTkuyGb9x6WyHw88A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUkgnkytm/McmpcCGnwX/AJuDcWbVK8QIBZkcGYaOL1cysZab7
	OkmDi5EnWIVoocat/UIGvyNxeSV/yfeRDI2CrbI2mMnZK4765b0vi4ofWOo/ATw=
X-Google-Smtp-Source: AGHT+IGSyjqaXLwQc37zez1HA3/9odmd9/yVOWTdmYy4wu/O1qCk3XNwZEvh8HYjK/OdZjH8X2vmFQ==
X-Received: by 2002:a17:90b:4c4a:b0:2d3:bc5f:715f with SMTP id 98e67ed59e1d1-2dad4df9581mr4811501a91.10.1725648483419;
        Fri, 06 Sep 2024 11:48:03 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc03700dsm1954913a91.21.2024.09.06.11.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 11:48:03 -0700 (PDT)
Date: Fri, 06 Sep 2024 11:48:03 -0700 (PDT)
X-Google-Original-Date: Fri, 06 Sep 2024 11:48:00 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: Allow to enable PREEMPT_RT.
In-Reply-To: <20240906151324.tVwX6lFy@linutronix.de>
CC: bigeasy@linutronix.de, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, hpa@zytor.com,
  aou@eecs.berkeley.edu, bp@alien8.de, Catalin Marinas <catalin.marinas@arm.com>, williams@redhat.com,
  dave.hansen@linux.intel.com, mingo@redhat.com, john.ogness@linutronix.de,
  Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
  Will Deacon <will@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: namcao@linutronix.de
Message-ID: <mhng-64eec780-df98-4e8d-bf6c-0aa07a8d85da@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 06 Sep 2024 08:13:24 PDT (-0700), namcao@linutronix.de wrote:
> On Fri, Sep 06, 2024 at 12:59:06PM +0200, Sebastian Andrzej Siewior wrote:
>> It is really time.
>>
>> riscv has all the required architecture related changes, that have been
>> identified over time, in order to enable PREEMPT_RT. With the recent
>> printk changes, the last known road block has been addressed.
>>
>> Allow to enable PREEMPT_RT on riscv.
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>
> With the printk patches applied:
>
> Tested-by: Nam Cao <namcao@linutronix.de> # Visionfive 2


Thanks.  LMK if you guys want me to take this through the RISC-V tree, 
but no big deal if you want it somewhere else -- and if there's some 
dependencies already going in through some sort of RT tree maybe that's 
just easier.  So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

I don't have a test setup yet, but I figure it's a new feature so I'll 
just flip it on as a config post-rc1.  Presumably this just works in the 
QEMU virt board, or is there some wizardry I'll need to copy?

> Best regards,
> Nam

