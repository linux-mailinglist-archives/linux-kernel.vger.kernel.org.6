Return-Path: <linux-kernel+bounces-392164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1819B9076
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7155B1C216D1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4819B5A5;
	Fri,  1 Nov 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMFJ9PM7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE615820C;
	Fri,  1 Nov 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461339; cv=none; b=HcgpYhDDUUGy2ez8MMwtrM52lg9lqXubWYrRrSGxvQTtVkbYfQGlS4UtBo59B9832mN9wSkeOA3kxf3ILuDeFlnF7sDDpZzos34JQbbZNQJf6Gnw+AbtHoAp5mbzY5yLBojsyVSy15A/ybi4DoMkj9wsa3tpnRsFAGqLs3y5Sq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461339; c=relaxed/simple;
	bh=6xrGD7oKWlZ6XOU+8wWyQpg+NtkqgDu0wWDFBNCgLS4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ApjjGRdjYBtjncWhRjScpgV7coxUffLL8437tn5C7L0JYEktdeTRbk7B81JBHwkpPSwxYsQG2QpiK9++hfE9ZXnbSkklJZEnp5vMs1FDlqkfZx38DtKzYs9g27CpXdHQXWu4O0ishJQDxrxREMyTElp6Y5OrqtNsEx/ni1wic+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMFJ9PM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FE8C4CECD;
	Fri,  1 Nov 2024 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730461339;
	bh=6xrGD7oKWlZ6XOU+8wWyQpg+NtkqgDu0wWDFBNCgLS4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=eMFJ9PM7hZnTN7+y6+MUNOnYAo9owzrlKfKHsVzt5++CJ4kCCAl3RRIBpSvwlPPQs
	 ill/6w/7zibQCyPz/in3wgbgH9Twni9Eydc7LrPUOp93ebcCQe3Z78Sl0qsJy+FJQX
	 db2eWi95HC5rIdDU8IFaNp9L/QRqWsQdaafUZCA4pjFzQ5O4PzaAXoVea1yfpy/xoe
	 MDeQVNeRotYoVc8IkXfht5kCz/STxKxSGMKuhfmhNqFXLjFKxKs4OceiUn20dxoaEh
	 5fBCMd9p6xUhDTtlq8NaxvepKM0Y/eyWFyXtgXVtZk5ydBRzBzAa0MjNu8Gx4oTy0t
	 WMzWMoUIOjmVw==
Date: Fri, 01 Nov 2024 06:42:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Abhishek Sahu <absahu@codeaurora.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Imran Shaik <quic_imrashai@quicinc.com>, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20241101-qcs615-mm-clockcontroller-v2-5-d1a4870a4aed@quicinc.com>
References: <20241101-qcs615-mm-clockcontroller-v2-0-d1a4870a4aed@quicinc.com>
 <20241101-qcs615-mm-clockcontroller-v2-5-d1a4870a4aed@quicinc.com>
Message-Id: <173046133538.2741746.9760905670245295955.robh@kernel.org>
Subject: Re: [PATCH v2 05/11] dt-bindings: clock: Add Qualcomm QCS615
 Display clock controller


On Fri, 01 Nov 2024 16:08:17 +0530, Taniya Das wrote:
> Add DT bindings for the Display clock on QCS615 platforms. Add the
> relevant DT include definitions as well.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  .../bindings/clock/qcom,qcs615-dispcc.yaml         | 73 ++++++++++++++++++++++
>  include/dt-bindings/clock/qcom,qcs615-dispcc.h     | 52 +++++++++++++++
>  2 files changed, 125 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.example.dts:19:18: fatal error: dt-bindings/clock/qcom,qcs615-gcc.h: No such file or directory
   19 |         #include <dt-bindings/clock/qcom,qcs615-gcc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/clock/qcom,qcs615-dispcc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241101-qcs615-mm-clockcontroller-v2-5-d1a4870a4aed@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


