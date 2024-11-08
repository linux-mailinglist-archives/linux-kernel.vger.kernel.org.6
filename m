Return-Path: <linux-kernel+bounces-401397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FCF9C19B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ADF287A39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6821E22FB;
	Fri,  8 Nov 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DX1HwiBR"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613B1E1C04
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059957; cv=none; b=dNmDgZDrHtubLHqJrh0gV5p2GL113isNkGcCOXEhB0SwRP2LhmsIPVLvegZs8WXPpIyl/BoHvHKyPxDsuYLFPdlR807L5nevLOxaDXe35FlKSVGfyjQ9E9Uz3fyBrQirnpcuPTm0Iu/g4vrESwP4bw0g+YW/PNA0inm9mGM1YXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059957; c=relaxed/simple;
	bh=favIJ0RU0Z1kVo0+cj+p8TtzOVJuzqN1053K+zk2H3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QXJEYqwqqEed/ZwO9O+LAQXCFeEJFmTCRzQitTPjnS6w1OdexCluBd7lyLAZPiaGj2iPOkF2bvDv9+sEMSxdLOQil/DwZryokrrqRqZj6mqxf8aVRi3O/2vLeKmroL4O/2yhQ/Scdj8csqmBsp80Y3AXG5mi//1jHTlpKX0qDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DX1HwiBR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so15881115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 01:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731059953; x=1731664753; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eTIHfF+UH1Xa7DK8o/xh7XL9H7nZTNldWgZ8nJ8rQE0=;
        b=DX1HwiBRwhGXitdHvqQR2GUb0yuMG/hW9E7sDsDJVkq3IAvNfBcNnBSonDnMckfvp9
         iQLsC5m0tzIgXMKscNxxSL5AJ1yFVz9k1wllbwVMg0yRzYPvh801Xv/f7OIGVJEltItM
         fUj7cOCqZ+q/X7wp1ansYdELaBTjzNMFmL41fbIZR5dPbgo9rJKZn+qSBS7En1ozX/WV
         avczIqxECniiFbpCuFgBJrXURyEu7HB/lpQIJLPoW6p4WqaaMHvQOoWVR0+M/UGwOrxA
         zRk8mGkhHr0e/HXZ3fxU0R6UxTPMLcHcrmTlCFqwvDGnkVqwpxqLArI9nt7NJyvCs4fO
         n9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059953; x=1731664753;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTIHfF+UH1Xa7DK8o/xh7XL9H7nZTNldWgZ8nJ8rQE0=;
        b=aWG8vRCbnv7vtAA5MrLB770dFJc2bdyxjCpmGXE76QaYhJjj3Ko6WTHDNI+sQ0Ymsn
         IffE8MFG2UMjPFQ+kvSp/NUovgb3DWvMXICBvfDHkyLVRIUyoyOBQBz4WzCQ8GWeV7Mw
         KbSa91VDngmzNVsNwKeCsvLAM+hZNUtgr1WEcSOHW/qRGNeFZTB36xHaaumoprkaje/t
         Vp5FqmXgR5uC+j+HHTHCO50qE3k23LMUHCaJiLzE6xICrMMQFzt+czUFIVcMjhrRqMq7
         6aUuCSMZDDo0hdaOYABB5vMM4zcFsgEmZ9E3B9+mqZog8eDr39uZTXkkHf6mvxk5vKvN
         BPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxi57SKRlAHKg3gIXIMOKvBCccBhagBvOXvdD8J1Jo50cN92MoOo3o2TCfOjUc8ORo+rPKUlJXTmt7L5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4O3IyYip/PeHkdEvgET9T1G929YQYFvUFmtwfZRGUQ96YxOvK
	Ig8r5EOmm60O3A4qBlHiU91NONFBinqgRD1r0f6rLZevzJFuhqL5MN8g1Crv5Tg=
X-Google-Smtp-Source: AGHT+IE52uNEd1M4kmQsGgrrxZ5e+HBgRbQ6hYCN5h70Y/Y7u6ZLc+ouQ9mgPck15oFzZ/AUamay2Q==
X-Received: by 2002:a05:600c:4f87:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-432b7508053mr18099615e9.18.1731059953350;
        Fri, 08 Nov 2024 01:59:13 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:ecfd:9f8d:62a3:6ba8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b0530599sm58205685e9.1.2024.11.08.01.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:59:12 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] clk: core: refine disable unused clocks
In-Reply-To: <85aae140-5c9b-4ff9-a522-549009f62601@amlogic.com> (Chuan Liu's
	message of "Fri, 8 Nov 2024 17:23:53 +0800")
References: <1jcykltj7g.fsf@starbuckisacylon.baylibre.com>
	<20241004133953.494445-1-jbrunet@baylibre.com>
	<07594a59-c999-4592-84b8-4e163d3edba4@amlogic.com>
	<1jttci2k8k.fsf@starbuckisacylon.baylibre.com>
	<85aae140-5c9b-4ff9-a522-549009f62601@amlogic.com>
Date: Fri, 08 Nov 2024 10:59:12 +0100
Message-ID: <1jcyj62gi7.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 08 Nov 2024 at 17:23, Chuan Liu <chuan.liu@amlogic.com> wrote:

>>>> -       if (core->flags & CLK_IGNORE_UNUSED)
>>>> +       /*
>>>> +        * If the parent is disabled but the gate is open, we should sanitize
>>>> +        * the situation. This will avoid an unexpected enable of the clock as
>>>> +        * soon as the parent is enabled, without control of CCF.
>>>> +        *
>>>> +        * Doing so is not possible with a CLK_OPS_PARENT_ENABLE clock without
>>>> +        * forcefully enabling a whole part of the subtree.  Just let the
>>>> +        * situation resolve it self on the first enable of the clock
>>>> +        */
>>>> +       if (!parent_enabled && (core->flags & CLK_OPS_PARENT_ENABLE))
>
> At first, I couldn't grasp the logic behind the 'return' here. Now it's
> clear. This approach is equivalent to completely giving up on
> handling clocks with CLK_OPS_PARENT_ENABLE feature in
> clk_disable_unused_subtree().
>

No. It's handled correctly as long as the tree is in coherent state.

What is not done anymore is fixing up an inconsistent tree, by this I
mean: A clock with CLK_OPS_PARENT_ENABLE, which report enabled from its
own registers but has its parent disabled.

In that particular case, clk_disable_unused_subtree() won't be turning on
everything to properly disable that one clock. That is the root cause of
the problem you reported initially. The clock is disabled anyway.

Every other case are properly handled (at least I think).

>>>>                   goto unlock_out;
>>>>
>>>>           /*
>>>> @@ -1516,8 +1545,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
>>>>
>>>>    unlock_out:
>>>>           clk_enable_unlock(flags);
>>>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>>>> -               clk_core_disable_unprepare(core->parent);
>>>> +       return (core->flags & CLK_IGNORE_UNUSED) && enabled;
>>>>    }
>>>>
>>>>    static bool clk_ignore_unused __initdata;
>>>> @@ -1550,16 +1578,16 @@ static int __init clk_disable_unused(void)
>>>>           clk_prepare_lock();
>>>>
>>>>           hlist_for_each_entry(core, &clk_root_list, child_node)
>>>> -               clk_disable_unused_subtree(core);
>>>> +               clk_disable_unused_subtree(core, true);
>>>>
>>>>           hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>> -               clk_disable_unused_subtree(core);
>>>> +               clk_disable_unused_subtree(core, true);
>>>>
>>>>           hlist_for_each_entry(core, &clk_root_list, child_node)
>>>> -               clk_unprepare_unused_subtree(core);
>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>
>>>>           hlist_for_each_entry(core, &clk_orphan_list, child_node)
>>>> -               clk_unprepare_unused_subtree(core);
>>>> +               clk_unprepare_unused_subtree(core, true);
>>>>
>>>>           clk_prepare_unlock();
>>>>
>>>> --
>>>> 2.45.2
>>>>
>> --
>> Jerome

-- 
Jerome

