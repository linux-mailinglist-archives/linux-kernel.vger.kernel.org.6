Return-Path: <linux-kernel+bounces-202687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 158278FCF99
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FB91F26BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C23196428;
	Wed,  5 Jun 2024 13:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZLJnxgTt"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CB196445
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593469; cv=none; b=VAh7N7+gwO3qvfv1yDSNV+HRNDenhIvB8wpLk7N9FbQNGzfj3WLMvRHXvzJmvO9NZ/hJy+VTlF/iMfYUyUs+k2TFJu+c6PXc8TnHH27I9lrcC2bAvbZqrlFKOl7goBlDVrQEFM8M9Dwsqcv7OEYMFNCsOxczJ5jYgJqZMNqP6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593469; c=relaxed/simple;
	bh=UbV1sT8AS69/0/WZMNU3BGlPEbAGUqxSRMbU/smTrno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUTWNKDCl6pQWYrFHmwu32GrxBpex37N7XLHhLdhCUtB5GjnoV0PE8Yl+gQIyOJrPQ2EtgiBwIWpe3m8hcYWhKgLqMw4kVMnRktdHiZu4j8Z19N/Wn8DWAS4oX1VqNGfe6CVkfvr0NFds1bItAkTQ34QnsvfQUZfbWfUKJhUMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZLJnxgTt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ae60725ea1so12813586d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717593466; x=1718198266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ezuh5lGjLmqQRDAtTge21GLODf9j9mNeQLiZ4DM7Eo8=;
        b=ZLJnxgTtfEe7UgK23K2WMWeyxEveDAdwJnDlGrRZDi4C8p/0X7234PCLQvDxs8wuxl
         fv2euZQ9Nlcxq19uXrlYzXZ0R4DJotEUI+44n2ND5DktIniUNJDVEYLhKM/tCL/hqAeT
         1wWT9z/574tbBVELKuv90t8SELIO8Lh91dPS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593466; x=1718198266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ezuh5lGjLmqQRDAtTge21GLODf9j9mNeQLiZ4DM7Eo8=;
        b=cMQoUqYTH4Vn9ZlMuVGt8CeG984V6kxjXTspPHsSKG1RyZhG5EA0mqV/hNKBLWR/SL
         RkLBfUtxs485nd8G2NLYipVDhz5nh3fLNGDwTJPZXz53Q0zsEHsizQlQnZsqfU54T2IJ
         IhHQlP5YJFxsQuJtbPji5+rJ1YiIZzkdHNlOOKrFbvlRLWMW4U15+ul2ccJPnCNvvotZ
         QovPK/+F8061HMchDtubmFqRnFKT6am4suD7+O/b0rmSfHGZFR3TwDiublSXEeI5E7un
         ABZUvWnezBrcYzT/aFz0s7LSEMd04a+4iX/JHsE+0kfPxs6tegsibjR5PlWjIBMjeiT9
         q8zw==
X-Forwarded-Encrypted: i=1; AJvYcCWhaduHUGAtcE2qGYBb1vgPUabEtZ0naLmLXDJPgZzLCaSXKkcOLpiq7JpkfPEaHsQrpaMltosxfsGZfikGlo4/fc7Rny2SIAvQVwg0
X-Gm-Message-State: AOJu0YxCpK0jGyCIAY0ZUjWHFtUnPUTbEgAka9KWOJfVLw4UMq48hc0i
	IrmLMqW7/zhB2xXw8Swxpgr+ue+Nh9tEarFgy6O4jQjHNVYaMjgH9mUupL0J1BPoVfzA/A0AFvA
	Y0MGkdm1oflgDB54A9LUZsQBHFqi/3zYoY7nX
X-Google-Smtp-Source: AGHT+IFwlOu7J6J8+q1Yt7bJvu3b6VcYZUPhTKYQf1CywqeXzPU2nzQSpBxs1jCwjEtcxcqI7XXwr7kTGdat1wGgTw4=
X-Received: by 2002:a05:6214:5d8b:b0:6ab:83a5:195 with SMTP id
 6a1803df08f44-6b030a96731mr26255756d6.41.1717593465943; Wed, 05 Jun 2024
 06:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
In-Reply-To: <20240521-board-ids-v3-0-e6c71d05f4d2@quicinc.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Jun 2024 07:17:35 -0600
Message-ID: <CAFLszTjexpNEjo1sGVs67L0CAgGZLNkyn9RGfHRD7iHak_mtmg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/9] dt-bindings: hwinfo: Introduce board-id
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Amrit Anand <quic_amrianan@quicinc.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Andy Gross <agross@kernel.org>, 
	Doug Anderson <dianders@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Julius Werner <jwerner@chromium.org>, "Humphreys, Jonathan" <j-humphreys@ti.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Jon Hunter <jonathanh@nvidia.org>, 
	Michal Simek <michal.simek@amd.com>, boot-architecture@lists.linaro.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Elliot,

On Tue, 21 May 2024 at 12:38, Elliot Berman <quic_eberman@quicinc.com> wrote:
>
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.
>
> This series is based off a talk I gave at EOSS NA 2024 [1]. There is
> some further discussion about how to do devicetree selection in the
> boot-architecture mailing list [2].
>
> [1]: https://sched.co/1aBFy
> [2]: https://lists.linaro.org/archives/list/boot-architecture@lists.linaro.org/thread/DZCZSOCRH5BN7YOXEL2OQKSDIY7DCW2M/
>
> Quick summary
> -------------
> This series introduces a new subnode in the root:
> / {
>         board-id {
>                 some-hw-id = <value>;
>                 other-hw-id = <val1>, <val2>;
>         };
> };
>
> Firmware provides a mechanism to fetch the values of "some-hw-id" and
> "other-hw-id" based on the property name. I'd like to leave exact
> mechanism data out of the scope of this proposal to keep this proposal
> flexible because it seems architecture specific, although I think we we
> should discuss possible approaches. A DTB matches if firmware can
> provide a matching value for every one of the properties under
> /board-id. In the above example, val1 and val2 are both valid values and
> firmware only provides the one that actually describes the board.
>
> It's expected that devicetree's board-id don't describe all the
> properties firmware could provide. For instance, a devicetree overlay
> may only care about "other-hw-id" and not "some-hw-id". Thus, it need
> only mention "other-hw-id" in its board-id node.
>
> Isn't that what the compatible property is for?
> -----------------------------------------------
> The compatible property can be used for board matching, but requires
> bootloaders and/or firmware to maintain a database of possible strings
> to match against or implement complex compatible string matching.
> Compatible string matching becomes complicated when there are multiple
> versions of board: the device tree selector should recognize a DTB that
> cares to distinguish between v1/v2 and a DTB that doesn't make the
> distinction.  An eeprom either needs to store the compatible strings
> that could match against the board or the bootloader needs to have
> vendor-specific decoding logic for the compatible string. Neither
> increasing eeprom storage nor adding vendor-specific decoding logic is
> desirable.

That is not necessary, though. The compatible string should be enough.

>
> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
> -------------------------------------------------------------
> The selection process for devicetrees was Qualcomm-specific and not
> useful for other devices and bootloaders that were not developed by
> Qualcomm because a complex algorithm was used to implement. Board-ids
> provide a matching solution that can be implemented by bootloaders
> without introducing vendor-specific code. Qualcomm uses three
> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
> pmic-id.  This does not scale well for use casese which use identifiers,
> for example, to distinguish between a display panel. For a display
> panel, an approach could be to add a new property: display-id, but now
> bootloaders need to be updated to also read this property. We want to
> avoid requiring to update bootloaders with new hardware identifiers: a
> bootloader need only recognize the identifiers it can handle.
>
> Notes about the patches
> -----------------------
> In my opinion, most of the patches in this series should be submitted to
> libfdt and/or dtschema project. I've made them apply on the kernel tree
> to be easier for other folks to pick them up and play with them. As the
> patches evolve, I can send them to the appropriate projects.
>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
> Changes in v3:
>  - Follow new "/board-id {}" approach, which uses key-value pairs
>  - Add match algorithm in libfdt and some examples to demo how the
>    selection could work in tools/board-id
>
> Changes in V2:
>  - Addressed few comments related to board-id, and DDR type.
>  - Link to V2:  https://lore.kernel.org/all/a930a3d6-0846-a709-8fe9-44335fec92ca@quicinc.com/#r
>
> ---
> Amrit Anand (1):
>       dt-bindings: arm: qcom: Update Devicetree identifiers
>
> Elliot Berman (8):
>       libfdt: board-id: Implement board-id scoring
>       dt-bindings: board: Introduce board-id
>       fdt-select-board: Add test tool for selecting dtbs based on board-id
>       dt-bindings: board: Document board-ids for Qualcomm devices
>       arm64: boot: dts: sm8650: Add board-id
>       arm64: boot: dts: qcom: Use phandles for thermal_zones
>       arm64: boot: dts: qcom: sm8550: Split into overlays
>       tools: board-id: Add test suite
>
>  .../devicetree/bindings/board/board-id.yaml        |  24 ++++
>  .../devicetree/bindings/board/qcom,board-id.yaml   | 144 ++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/Makefile                  |   4 +
>  arch/arm64/boot/dts/qcom/pm8010.dtsi               |  62 ++++-----
>  arch/arm64/boot/dts/qcom/pm8550.dtsi               |  32 ++---
>  arch/arm64/boot/dts/qcom/pm8550b.dtsi              |  36 +++--
>  arch/arm64/boot/dts/qcom/pm8550ve.dtsi             |  38 +++---
>  arch/arm64/boot/dts/qcom/pm8550vs.dtsi             | 128 +++++++++--------
>  arch/arm64/boot/dts/qcom/pmr735d_a.dtsi            |  38 +++---
>  arch/arm64/boot/dts/qcom/pmr735d_b.dtsi            |  38 +++---
>  .../dts/qcom/{sm8550-mtp.dts => sm8550-mtp.dtso}   |  24 +++-
>  .../dts/qcom/{sm8550-qrd.dts => sm8550-qrd.dtso}   |  22 ++-
>  .../boot/dts/qcom/{sm8550.dtsi => sm8550.dts}      |  10 +-
>  arch/arm64/boot/dts/qcom/sm8650-mtp.dts            |   6 +
>  arch/arm64/boot/dts/qcom/sm8650-qrd.dts            |   6 +
>  arch/arm64/boot/dts/qcom/sm8650.dtsi               |   2 +-
>  include/dt-bindings/arm/qcom,ids.h                 |  86 ++++++++++--
>  scripts/dtc/.gitignore                             |   1 +
>  scripts/dtc/Makefile                               |   3 +-
>  scripts/dtc/fdt-select-board.c                     | 126 +++++++++++++++++
>  scripts/dtc/libfdt/fdt_ro.c                        |  76 +++++++++++
>  scripts/dtc/libfdt/libfdt.h                        |  54 ++++++++
>  tools/board-id/test.py                             | 151 +++++++++++++++++++++
>  23 files changed, 901 insertions(+), 210 deletions(-)
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240112-board-ids-809ff0281ee5
>
> Best regards,
> --
> Elliot Berman <quic_eberman@quicinc.com>
>

I am just picking up the discussion here, which was started on another thread.

I can't see why this new feature is needed. We should be able to use
compatible strings, as we do now. I added a 'usage' section to the FIT
spec [1] which might help. I also incorporated the board revision and
variant information and some notes on how to add to the available
suffixes.

Does that handle your use case?

Regards,
Simon

[1] https://github.com/open-source-firmware/flat-image-tree/blob/main/source/chapter3-usage.rst

