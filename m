Return-Path: <linux-kernel+bounces-207081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB0490122A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08621F21C76
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BE615D5CB;
	Sat,  8 Jun 2024 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bfs8qCpS"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F45482DA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717858587; cv=none; b=AhX8wMrTQlx2PFYn3zQCSVntG/OBwUtxVDG+quYJEauGbvqyZlX4wZ0dl2XDfHQRG8qqOwpBu+18/78/s9aXXNjjaL535GJN+lp4mUktMPItZXi0B67Qtk++cfJGmfOdJt1kRa+0Hfx1UfL1MNNcCw1OUa1xLeRNNw64EDiP0X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717858587; c=relaxed/simple;
	bh=dqPQf0sQY27ayUqdo+VIE8le+JpFdCmmdo4c64tioGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJBatX1HgwVEwglRi2nCeLT18LLkOngG6p4cHOTLWasWIkJaa6j+AS50LCtRzokEVdANKq98yAw/cYQd0el0R8qKdNUaiwaLGDLM1mwZWtGS8UnAKKFbLMvQg/w8BB1UabdyrkeEnBVXEjGGlUpdNbjEU+NallKNDMj5wBNo8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bfs8qCpS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfab5f7e749so3050137276.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717858584; x=1718463384; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XsX3hty+D+AHRDtvdfjVtw4OVbF3WX5AC3es8JeM3yw=;
        b=Bfs8qCpSezWdJlFg91m4Oylb4pViCnlj7EbBvVx7u4SMv2n29OmdU3oZ4mpbKgCFyh
         WNtbF9mcEaD9zDUrK8gUUDj/Pwv7VyvI8OvTokQgNSTjyvobHJzuQbphETYZiEG7Rt7t
         45CBJ7XKS4bcDFh+yVNnQ5Xk2CrM65NOWsfP879AWTndKHoMzQO1vrzUuteQjhUrY2cI
         wzFRKewiiwskj6cgVyjgEN8e0IcxvhALOJeWyVldSxYptNXdPtVrqt3okdwkj9RQ00jP
         D54H23/C/I6eHuc7kOypWkWWPbsOzjM0lCWVk1e57XmiFZO+qnQoGQOSIEPLwMg6fQ5l
         b25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717858584; x=1718463384;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XsX3hty+D+AHRDtvdfjVtw4OVbF3WX5AC3es8JeM3yw=;
        b=Gd7j0qJoCcPoi5eqZLTb3JhH3IXAkj0RugBp/U0xjcX1W1e+rtaE0igMF73o7Ih/zX
         4mvYPeCbHJnnEfn6Lj+bwd5lRKkoTLmCvQR8ffMEAlMtC/KU50dioBDok8tsFRHwxy0P
         h0UoNrSQer7RSepMXqPThbJu3VfMk1DqLF4PogQTYiYaIi7UlJk0K4pBiYZC/7E8c+KJ
         9RwfuSFsNtnP1i0BRJP2wDlFTZCWGt09enNzQMeW/kqdXQjoiqsSp1G6lChGWE0MYRLy
         srb2d9qfjpK4ThY6QxXgY3yrK8A7QESWueeW/2yokAGcP0Q9TjaSn0M83wbXrD9M+UPk
         5Dwg==
X-Forwarded-Encrypted: i=1; AJvYcCVgKInPpTbAPP2UPK+1v5m1hsYwzvR6Kvg+lW3SCBYa4k0qa7bjTro/qfbddrKX4tYLNLz/+LeIohoQ2C5BIJbgrVa6pB0NhT3sCDQP
X-Gm-Message-State: AOJu0YxBVRkdptmcldgr5euCTN4hWk2IeAIPdx2LfNVjRL4vIPnHwWaA
	69ouJDwG/ezt6CZteXaJpV7QXJ9qWjd7UnI+A32VQQLGFesR4Bh99LViOxZVCPJ1+qwGIwG3gMY
	TRQ6DW/z6YLjLEKohb0z8rd2xyJR5K5fC4p6c6yk+8omJ/5Y5IhY=
X-Google-Smtp-Source: AGHT+IGZWqZUzqNrVGDIoc1u0I2wXkZf1wtlFQPedLfZtvoKBbtfCQI3l9B9610V7doEPtEk0nqZWOyQbdZ9z8mJOeo=
X-Received: by 2002:a25:244:0:b0:dfb:14cb:f08b with SMTP id
 3f1490d57ef6-dfb14cbf21dmr846140276.23.1717858584122; Sat, 08 Jun 2024
 07:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
 <i6jwqycgywrq42u4km6pjppgvvhsbvuh7m6mzyqy2qcge32ihy@n3lrowkyouv2> <3ea05a12-27a8-46df-9fb3-28501404a399@linaro.org>
In-Reply-To: <3ea05a12-27a8-46df-9fb3-28501404a399@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 8 Jun 2024 17:56:13 +0300
Message-ID: <CAA8EJpqMk9vujHAmF+xSKBDzR1LM9w-M7a8vxcCkXey9VpHBhA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ASoC: qcom: display port changes
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, lgirdwood@gmail.com, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Jun 2024 at 12:12, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks Dmitry for testing this out.
>
> On 08/06/2024 03:23, Dmitry Baryshkov wrote:
> > On Thu, Jun 06, 2024 at 11:49:18AM +0100, srinivas.kandagatla@linaro.org wrote:
> >> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> >>
> >> This patchset adds support for.
> >>      1. parse Display Port module tokens from ASoC topology
> >>      2. add support to DP/HDMI Jack events.
> >>      3. fixes a typo in function name in sm8250
> >>
> >> Verified these patches on X13s along with changes to tplg in
> >> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
> >> and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> >>
> >> x1e80100 is verified by Krzysztof with his changes in tplg
> >>
> >> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/merge_requests/7/commits
> >>
> >> Thanks,
> >> Srini
> >>
> >
> > I have been testing this patchset on X13s, switching between speakers,
> > connected and disconnected DP output.
> >
>
> This series changed the Jack event names by removing HDMI string from it
> as suggested, did you update the UCM to reflect this?

Yes, I did. The pipewire properly reports 'unconnected' state, but
nothing stops user from selecting the unconnected device / verb.

> I have pushed changes required to
> https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
>
>
> Can you also try to  clean the asound.state restart the pipewire.
>
> > - Once the DSP got into the state, where I could not further get it to
> >    work until the reboot:
> >
> > rohan pipewire[1749]: spa.alsa: set_hw_params: Invalid argument
> > rohan pipewire[1749]: pw.node: (alsa_output.platform-sound.HiFi__hw_SC8280XPLENOVOX_1__sink-48) suspended -> error (Start error: Invalid argument)
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
> > rohan kernel: q6apm-lpass-dais 3000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to prepare Graph -22
> > rohan kernel: q6apm-lpass-dais 3000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at snd_soc_pcm_dai_prepare on WSA_CODEC_DMA_RX_0: -22
> > rohan pipewire[1749]: spa.alsa: set_hw_params: Invalid argument
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
> > rohan kernel: q6apm-lpass-dais 3000000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to prepare Graph -22
> > rohan kernel: q6apm-lpass-dais 3000000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC: error at snd_soc_pcm_dai_prepare on WSA_CODEC_DMA_RX_0: -22
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001006 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001006] 1
> > rohan kernel: qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001001 cmd
> > rohan kernel: qcom-apm gprsvc:service:2:1: DSP returned error[1001001] 1
> >
> >
> > - Once in a while during startup PipeWire will try opening the
> >    incorrect DAI and then fail with:
> >
> > rohan kernel: hdmi-audio-codec hdmi-audio-codec.8.auto: ASoC: error at snd_soc_dai_hw_params on i2s-hifi: -22
> > rohan kernel: hdmi-audio-codec hdmi-audio-codec.8.auto: ASoC: error at snd_soc_dai_hw_params on i2s-hifi: -22
> >
> >    I think this happens if previously I have selected DP as an output,
> >    then closed gnome session, unplugged the cable and tried logging in
> >    again.
> >
> > Generally, it looks like even though the Jack is reporting
> > 'unplugged', sound daemon still can switch to to the disabled output
> I think this is to do with ucm changes requried for new jack name.

No. The jack (and the pipewire status) reports unconnected.

>
> > (or the audio card can be left in the stale state).  In case of DP
> > this frequently results in audio daemon or DSP failures.
> >
> > So, the DP implementation needs to be made more robust, so that if
> > DP output gets selected when the cable is unplugged, the driver will not
> > attempt to configure the DSP.
>
> I have tested this with
>
> kernel:
> https://git.codelinaro.org/srinivas.kandagatla/linux/-/tree/dp/sc8280xp-6.10-rc1?ref_type=heads
> ucm: https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp
> tplg:
> https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
>
>
> with the above on my x13s, I can properly do switching between dp0,dp1
> and speakers with no issues.

Have you tried switching to the unconnected sink? Starting the
pipewire when the previously selected sink is now disconnected?

>
> Can you try them?

Is the changing of the JACK names the only change in the UCM? compared
to your previous version?

I've used the following topology, fom the topology repo / x13s-dp branch

5206af2e1915b8dba52da2e59fb5ebff audioreach-tplg.bin




-- 
With best wishes
Dmitry

