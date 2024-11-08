Return-Path: <linux-kernel+bounces-401286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBE99C1834
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D721F24408
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1B1DFDA2;
	Fri,  8 Nov 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D8pXmSd0"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D937D1DF759
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055123; cv=none; b=W+BCcBNlNqgipPwYPOA36KjrfpqpGrGF2axeHeiCk65+DVfYfKj5uJZObFN0+MpSJyb3JxAULM4hg9BGohZbDtqugDwKV/wkblxyW0Yj8rVMFJFovfv3+VHTVz8AY+Byr++6HPAyYFiCAl8cInlU9ewl/3+uErVnqguDeQsZrWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055123; c=relaxed/simple;
	bh=uzjmehk08CI+BWHMkzxNV+0c5znE/XBEVsdvIaa554s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEbGq/n3j6fYxnqHEr8HvzmnuRVrUSFowesJEoIcBiw2PVqIzaua5v/INTJ8Dcc5hiPbda0ZOqYOlW00it1j/oWVZiVkLdTa1vEGz/jvegtuNtc1/mFrqEf/LIL8n+n/xL6p9IfP7AgfoKUMVdfYU0VIVFlYIXeWBkrb73mbnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D8pXmSd0; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so1554941f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731055117; x=1731659917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJPKigWx81+Bm6PKRO3KqD8RhIP7gO2pTb9qdyrOl1k=;
        b=D8pXmSd061f0Be+yqWqJ0RCBc00XLr5JaVEdHXjgInlxmg1QrlJyHxXymdrU3c/OoJ
         6j+kbuvl9UUljlc7IaGr8X8pSKBKak2Pl4W4XUS2W/3546UE5Qn7MdeTTZxv1Ec4YY0S
         ocOstMdpRD66oqPuoiGQU9WTeTOWlzoo/7e0C2l+E0sacOluSmHPT5QnrQ8jEVRbWtnJ
         21hVLcCQfdkT13WOGSeDUS/J8J3unlldtA8V778qLthP4CoEM99xIPryV2ATw+C3aPFN
         E/iXPDBsOUVkGQ/cu6ufTwrV5ijzkY5lXv+r6hjgXwkMu/C0F+KTJwj6r5e2S/9gTz9C
         TjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731055117; x=1731659917;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJPKigWx81+Bm6PKRO3KqD8RhIP7gO2pTb9qdyrOl1k=;
        b=Inlj+t9w0bKbli9x3utFA+i2OtiZfXyogF97WV567fj+yzLxNP0+TzQN15qgIOhxiF
         3Z4m0wiYPkhL7uTdKI2zDeI2TS7esKD6uDxqS8Qi0t8M0DhRXVRSRpe2p77FZxCC3b7w
         i9cRdB8gMchiSqAgu3R7yRNbx0OPMDhhBUpEvcy+RDk2tdDFJL1QV7tEkr4cKC89P2JK
         iOBpK7tCDVB/Hr0tSQA8iP2ejfmrT4uX17h4ABkcFXIK/aJjSHyDWx3xdrIhr14h80Xh
         BBEEg1t/FoFT171mfEu9okUiV5GSEULP4LDlhaAJLEJkWqsuPHcx/K8ZzS5M6j/GT39Q
         yHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnz7NqVlhu7aE5u+TfGRwQKlCJ6iuB495zlRovlujaMBlrOQKHPUw/T52kJ6y3rUVHyv9HZHuA0KByuN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DZ/UFa4nZRKFmIb05cVOzHWDKau+c6SE3D73DtJuC5X96AGd
	GMif+lVvwwhJlW4DCMgb/SL2A3qRd7xHlrMbo4cuF5hqDBGrMd6BGBYvYz6byaY=
X-Google-Smtp-Source: AGHT+IG+dpyBpBdR+FT66n2a2IW5JPY+pZuJblPHBprC2qQv77X/mv3FdHl7bLc9o7ADckUNC0pp6w==
X-Received: by 2002:a5d:6f02:0:b0:37d:4319:f8c6 with SMTP id ffacd0b85a97d-381f1866ed9mr2004601f8f.7.1731055116940;
        Fri, 08 Nov 2024 00:38:36 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:ecfd:9f8d:62a3:6ba8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c2161sm54749155e9.31.2024.11.08.00.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 00:38:36 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Stephen Boyd <sboyd@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
  linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] clk: core: refine disable unused clocks
In-Reply-To: <07594a59-c999-4592-84b8-4e163d3edba4@amlogic.com> (Chuan Liu's
	message of "Fri, 8 Nov 2024 15:59:44 +0800")
References: <1jcykltj7g.fsf@starbuckisacylon.baylibre.com>
	<20241004133953.494445-1-jbrunet@baylibre.com>
	<07594a59-c999-4592-84b8-4e163d3edba4@amlogic.com>
Date: Fri, 08 Nov 2024 09:38:35 +0100
Message-ID: <1jttci2k8k.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri 08 Nov 2024 at 15:59, Chuan Liu <chuan.liu@amlogic.com> wrote:

> hi Jerome:
>
> =C2=A0=C2=A0=C2=A0 Tranks for your REF. I looked at your patch and there =
are some parts
> that I don't quite understand: The original intention of
> CLK_OPS_PARENT_ENABLE was to solve the issue of "parents need enable
> _during _gate/ungate, set rate and re-parent" when setting a clock. After
> setting the clock, it can still be disabled. However, from what I see in
> your patch, the handling logic seems more like "parents need _always _ ga=
te
> during clock gate period"?

As explained in the description, the problem with CLK_IGNORE_UNUSED and
CLK_OPS_PARENT_ENABLE is that you'll get cycle of enable/disable, which
will disable any parent clock that may have a been enabled and expected
to be ignored.

IOW, the CCF changes the state of the tree while inspecting it.
This change solves that.

>
> On 10/4/2024 9:39 PM, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>> As it as been pointed out numerous times, flagging a clock with
>> CLK_IGNORE_UNUSED does _not_ guarantee that clock left enabled will stay
>> on. The clock will get disabled if any enable/disable cycle happens on it
>> or its parent clocks.
>>
>> Because enable/disable cycles will disable unused clocks,
>> clk_disable_unused() should not trigger such cycle. Doing so disregard
>> the flag if set for any parent clocks. This is problematic with
>> CLK_OPS_PARENT_ENABLE handling.
>>
>> To solve this, and a couple other issues, pass the parent status to the
>> child while walking the subtree, and return whether child ignored disabl=
e,
>> or not.
>>
>> * Knowing the parent status allows to safely disable clocks with
>>    CLK_OPS_PARENT_ENABLE when the parent is enabled. Otherwise it means
>>    that, while the clock is not gated it is effectively disabled. Turnin=
g on
>>    the parents to sanitize the sitation would bring back our initial
>>    problem, so just let it sanitize itself when the clock gets used.
>>
>> * If a clock is not actively used (enabled_count =3D=3D 0), does not have
>>    CLK_IGNORE_UNUSED but the hw enabled all the way to the root clock, a=
nd a
>>    child ignored the disable, it should ignore the disable too. Doing so
>>    avoids disabling what is feading the children. Let the flag trickle d=
own
>>    the tree. This has the added benefit to transfer the information to t=
he
>>    unprepare path, so we don't unprepare the parent of a clock that igno=
red
>>    a disable.
>>
>> * An enabled clock must be prepared in CCF but we can't rely solely on
>>    counts at clk_disable_unused() stage. Make sure an enabled clock is
>>    considered prepared too, even if does not implement the related callb=
ack.
>>    Also make sure only disabled clocks get unprepared.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>
>>   This is sent as an RFC to continue the discussion started by Chuan.
>>   It is not meant to be applied as it is.
>>
>>
>>   drivers/clk/clk.c | 92 ++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 60 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index d02451f951cf..41c4504a41f1 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -332,17 +332,6 @@ static bool clk_core_is_enabled(struct clk_core *co=
re)
>>                  }
>>          }
>>
>> -       /*
>> -        * This could be called with the enable lock held, or from atomic
>> -        * context. If the parent isn't enabled already, we can't do
>> -        * anything here. We can also assume this clock isn't enabled.
>> -        */
>> -       if ((core->flags & CLK_OPS_PARENT_ENABLE) && core->parent)
>
> This judgment of CLK_OPS_PARENT_ENABLE seems redundant. According to
> normal logic, if the parent is disabled, its children will also be
> forced to disable. This seems unrelated to whether CLK_OPS_PARENT_ENABLE
> is configured.=F0=9F=98=B3

It's removed.

>
>> -               if (!clk_core_is_enabled(core->parent)) {
>> -                       ret =3D false;
>> -                       goto done;
>> -               }
>> -
>>          ret =3D core->ops->is_enabled(core->hw);
>>   done:
>>          if (core->rpm_enabled)
>> @@ -1454,22 +1443,39 @@ static void clk_core_disable_unprepare(struct cl=
k_core *core)
>>          clk_core_unprepare_lock(core);
>>   }
>>
>> -static void __init clk_unprepare_unused_subtree(struct clk_core *core)
>> +static bool __init clk_unprepare_unused_subtree(struct clk_core *core,
>> +                                               bool parent_prepared)
>>   {
>>          struct clk_core *child;
>> +       bool prepared;
>>
>>          lockdep_assert_held(&prepare_lock);
>>
>> +       /*
>> +        * Relying on count is not possible at this stage, so consider
>> +        * prepared an enabled clock, in case only .is_enabled() is
>> +        * implemented
>> +        */
>> +       if (parent_prepared)
>> +               prepared =3D (clk_core_is_prepared(core) ||
>> +                           clk_core_is_enabled(core));
>> +       else
>> +               prepared =3D false;
>> +
>>          hlist_for_each_entry(child, &core->children, child_node)
>> -               clk_unprepare_unused_subtree(child);
>> +               if (clk_unprepare_unused_subtree(child, prepared) &&
>> +                   prepared && !core->prepare_count)
>> +                       core->flags |=3D CLK_IGNORE_UNUSED;
>>
>> -       if (core->prepare_count)
>> -               return;
>> +       if (core->flags & CLK_IGNORE_UNUSED || core->prepare_count)
>> +               goto out;
>>
>> -       if (core->flags & CLK_IGNORE_UNUSED)
>> -               return;
>> +       if (!parent_prepared && (core->flags & CLK_OPS_PARENT_ENABLE))
>> +               goto out;
>>
>> -       if (clk_core_is_prepared(core)) {
>> +       /* Do not unprepare an enabled clock */
>> +       if (clk_core_is_prepared(core) &&
>> +           !clk_core_is_enabled(core)) {
>>                  trace_clk_unprepare(core);
>>                  if (core->ops->unprepare_unused)
>>                          core->ops->unprepare_unused(core->hw);
>> @@ -1477,27 +1483,50 @@ static void __init clk_unprepare_unused_subtree(=
struct clk_core *core)
>>                          core->ops->unprepare(core->hw);
>>                  trace_clk_unprepare_complete(core);
>>          }
>> +
>> +out:
>> +       return (core->flags & CLK_IGNORE_UNUSED) && prepared;
>>   }
>>
>> -static void __init clk_disable_unused_subtree(struct clk_core *core)
>> +static bool __init clk_disable_unused_subtree(struct clk_core *core,
>> +                                             bool parent_enabled)
>>   {
>>          struct clk_core *child;
>>          unsigned long flags;
>> +       bool enabled;
>>
>>          lockdep_assert_held(&prepare_lock);
>>
>> -       hlist_for_each_entry(child, &core->children, child_node)
>> -               clk_disable_unused_subtree(child);
>> +       flags =3D clk_enable_lock();
>>
>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>> -               clk_core_prepare_enable(core->parent);
>> +       /* Check if the clock is enabled from root to this clock */
>> +       if (parent_enabled)
>> +               enabled =3D clk_core_is_enabled(core);
>> +       else
>> +               enabled =3D false;
>>
>> -       flags =3D clk_enable_lock();
>> +       hlist_for_each_entry(child, &core->children, child_node)
>> +               /*
>> +                * If any child ignored disable, this clock should too,
>> +                * unless there is, valid reason for the clock to be ena=
bled
>> +                */
>> +               if (clk_disable_unused_subtree(child, enabled) &&
>> +                   enabled && !core->enable_count)
>> +                       core->flags |=3D CLK_IGNORE_UNUSED;
>>
>> -       if (core->enable_count)
>> +       if (core->flags & CLK_IGNORE_UNUSED || core->enable_count)
>>                  goto unlock_out;
>>
>> -       if (core->flags & CLK_IGNORE_UNUSED)
>> +       /*
>> +        * If the parent is disabled but the gate is open, we should san=
itize
>> +        * the situation. This will avoid an unexpected enable of the cl=
ock as
>> +        * soon as the parent is enabled, without control of CCF.
>> +        *
>> +        * Doing so is not possible with a CLK_OPS_PARENT_ENABLE clock w=
ithout
>> +        * forcefully enabling a whole part of the subtree.  Just let the
>> +        * situation resolve it self on the first enable of the clock
>> +        */
>> +       if (!parent_enabled && (core->flags & CLK_OPS_PARENT_ENABLE))
>>                  goto unlock_out;
>>
>>          /*
>> @@ -1516,8 +1545,7 @@ static void __init clk_disable_unused_subtree(stru=
ct clk_core *core)
>>
>>   unlock_out:
>>          clk_enable_unlock(flags);
>> -       if (core->flags & CLK_OPS_PARENT_ENABLE)
>> -               clk_core_disable_unprepare(core->parent);
>> +       return (core->flags & CLK_IGNORE_UNUSED) && enabled;
>>   }
>>
>>   static bool clk_ignore_unused __initdata;
>> @@ -1550,16 +1578,16 @@ static int __init clk_disable_unused(void)
>>          clk_prepare_lock();
>>
>>          hlist_for_each_entry(core, &clk_root_list, child_node)
>> -               clk_disable_unused_subtree(core);
>> +               clk_disable_unused_subtree(core, true);
>>
>>          hlist_for_each_entry(core, &clk_orphan_list, child_node)
>> -               clk_disable_unused_subtree(core);
>> +               clk_disable_unused_subtree(core, true);
>>
>>          hlist_for_each_entry(core, &clk_root_list, child_node)
>> -               clk_unprepare_unused_subtree(core);
>> +               clk_unprepare_unused_subtree(core, true);
>>
>>          hlist_for_each_entry(core, &clk_orphan_list, child_node)
>> -               clk_unprepare_unused_subtree(core);
>> +               clk_unprepare_unused_subtree(core, true);
>>
>>          clk_prepare_unlock();
>>
>> --
>> 2.45.2
>>

--=20
Jerome

