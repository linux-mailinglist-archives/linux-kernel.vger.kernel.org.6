Return-Path: <linux-kernel+bounces-429643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BF19E1F06
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49D65163C1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCF81F472D;
	Tue,  3 Dec 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co2V7fSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835A1DE2DE;
	Tue,  3 Dec 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235899; cv=none; b=A3b6O9M4HDAxgLzBIYuBEfytsIhGZMMc9TWoBDZ8+l+IPiVv5mc9NPQxDSXDEOc8CAO8DuWJP2DCC6HDY+m9LHcL19xq3W4Sh74HR/Y/kFB+WkDEZt73joA6HHj9D3fPad42F/enQS3ykFu/PtT9HqTlid1n4QJD5nTVO2T2ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235899; c=relaxed/simple;
	bh=DKmOU7vnkUqoQgoBcoXntMTXjpSRQwhxPRgQDZ5KdtU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=vEfooaoUdlVuQYfsBwyczvaR0ad2vRWRc6Nmf/12pmQLGtvH54iZm0Unaf78ZlUBN7UrNFQTkjuLCd8FwyO7tVk4j6XYpftgVtGPosE+boXNkxK8hOeyqcJMjSib3cNVYKnjppu5Rbva0TJSJTWX5v0k7CNdIB8CWspAR1/XVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co2V7fSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD77C4CED8;
	Tue,  3 Dec 2024 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733235899;
	bh=DKmOU7vnkUqoQgoBcoXntMTXjpSRQwhxPRgQDZ5KdtU=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Co2V7fSy5ZfdLr+VU+LEXPhBV1RGVb3XC0N4BvcXmZle40bb/bDgxXKxbL8EWyEgX
	 ehTkv5t4EHupg8b3wg66x51JtG/jCwgDNrNZadsTi2ZHt+lWO0+3bto9DKBEj3O7GW
	 h1OSEnLghbB8E9MbSCd4qA0YanTnWyeS0RrZFPBPpupM4RpbLRB8IoS4HTXDRLiH6G
	 ehB7Cu1myEGkH9U9L/laOJ7tr+D2U6Al15ozJGDl8ZO/kXyYtRPi8xbClkPoHEUOOI
	 PdGnXBIcuYwNFgQlMDAprEzCI4d1xtIgq7EdQaHMRhzw3Vhp8aI1B+zL8bYZC5+dxT
	 yVOXtExy4DzyA==
Date: Tue, 03 Dec 2024 08:24:57 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mripard@kernel.org, m.szyprowski@samsung.com, 
 maarten.lankhorst@linux.intel.com, mturquette@baylibre.com, 
 aou@eecs.berkeley.edu, tzimmermann@suse.de, frank.binns@imgtec.com, 
 simona@ffwll.ch, wefu@redhat.com, jszhang@kernel.org, 
 linux-pm@vger.kernel.org, drew@pdp7.com, guoren@kernel.org, 
 palmer@dabbelt.com, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, paul.walmsley@sifive.com, 
 linux-clk@vger.kernel.org, ulf.hansson@linaro.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, sboyd@kernel.org, 
 dri-devel@lists.freedesktop.org, matt.coster@imgtec.com, airlied@gmail.com, 
 jassisinghbrar@gmail.com, conor+dt@kernel.org
To: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20241203134137.2114847-3-m.wilczynski@samsung.com>
References: <20241203134137.2114847-1-m.wilczynski@samsung.com>
 <CGME20241203134151eucas1p18edf7fb37cd8f30983a559d7481f560b@eucas1p1.samsung.com>
 <20241203134137.2114847-3-m.wilczynski@samsung.com>
Message-Id: <173323589571.1743485.13611709278152187222.robh@kernel.org>
Subject: Re: [RFC PATCH v1 02/14] dt-bindings: clock: thead,th1520: Rename
 header file


On Tue, 03 Dec 2024 14:41:25 +0100, Michal Wilczynski wrote:
> As support for clocks from new subsystems is being added to the T-Head
> TH1520 SoC, the header file name should reflect this broader scope. The
> existing header file 'thead,th1520-clk-ap.h' includes the '-ap' suffix,
> indicating it's specific to the Application Processor (AP) subsystem.
> 
> Rename the header file to 'thead,th1520-clk.h' to generalize it for all
> subsystems.  Update all references to this header file accordingly.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../devicetree/bindings/clock/thead,th1520-clk-ap.yaml        | 4 ++--
>  .../devicetree/bindings/mailbox/thead,th1520-mbox.yaml        | 2 +-
>  MAINTAINERS                                                   | 2 +-
>  arch/riscv/boot/dts/thead/th1520.dtsi                         | 2 +-
>  drivers/clk/thead/clk-th1520.h                                | 2 +-
>  .../clock/{thead,th1520-clk-ap.h => thead,th1520-clk.h}       | 0
>  6 files changed, 6 insertions(+), 6 deletions(-)
>  rename include/dt-bindings/clock/{thead,th1520-clk-ap.h => thead,th1520-clk.h} (100%)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.example.dts:24:18: fatal error: dt-bindings/clock/thead,th1520-clk.h: No such file or directory
   24 |         #include <dt-bindings/clock/thead,th1520-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.example.dts:18:18: fatal error: dt-bindings/clock/thead,th1520-clk.h: No such file or directory
   18 |         #include <dt-bindings/clock/thead,th1520-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.example.dtb] Error 1
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241203134137.2114847-3-m.wilczynski@samsung.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


