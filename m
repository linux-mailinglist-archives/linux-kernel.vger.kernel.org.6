Return-Path: <linux-kernel+bounces-568586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F27A69800
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58E58A66E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8620AF89;
	Wed, 19 Mar 2025 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKhGZn1e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3085B1FB3;
	Wed, 19 Mar 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408752; cv=none; b=SSEX66k5A9Cw2+AI24v4c7llXtLUo5QVhpIJzh1qxiVH31wx2Xu8j9AZz/WvPSxVFfI3z8M4xRxDfpoYJbRezYbVG5gNchOZiX/lnS2EI4LWhItSTkoREuDqKs9tXZf9vw+BgT+xaClTqDE1PzIjHwxNeNcndRQ/a63kScQjJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408752; c=relaxed/simple;
	bh=04CMRe93ja+0dP91KUJ1g3Ym9I3uIUGjEdjdQChI45w=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Suz1Ia0cFd7AiASoQIDuqfedEoYRGJ2k0B8xWD0Ti7Acu5g4x3d5HiIPpEeh9t+FhTzNQWV4i1pqIfK61EXVwUGcLleJu44z83DICUzJOTnz9m/Sl601Pm7OA1Bmeh41u4/5nBYAbY5hhf6QPzN8gnlPzcGBVl/itb1EQLMOjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKhGZn1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0B2C4CEE4;
	Wed, 19 Mar 2025 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742408751;
	bh=04CMRe93ja+0dP91KUJ1g3Ym9I3uIUGjEdjdQChI45w=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=YKhGZn1eTu8aUzeBZK0hVZjTgVsbH+pITU9AswRjgdFmvNALPZBW6Hsz/YT4snIT1
	 zPHs9rSu85745og20w3OoufRJcUvEYhbaM0N1Ek6r+Sa+u/IqWVBd7E25MYo+oJ6fh
	 bm+Kv5PYf/pjPnrZYAzurjs7yWrRsIWQ8MzGm3Axnh6ZG4nnAqOEtpF+H5D3W6XqU9
	 0RluMZifkFxk6bA+BGUnTUQbF2x/gisXqZ+n8GFhjbS7460wVVGuOG3UXygpD2O5L/
	 1aCyrGLbrbFm3oNAKast4gtrE5vKViIyA4uTYQNDYVNEhqI0QnD82qGEoxiGoXqSfN
	 L1mk6lX8+YZTg==
Date: Wed, 19 Mar 2025 13:25:50 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, 
 linux-hwmon@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Flaviu Nistor <flaviu.nistor@gmail.com>
To: Flaviu Nistor <flaviu.nistor@googlemail.com>
In-Reply-To: <20250319170234.63723-3-flaviu.nistor@gmail.com>
References: <20250319170234.63723-1-flaviu.nistor@gmail.com>
 <20250319170234.63723-3-flaviu.nistor@gmail.com>
Message-Id: <174240875028.2079791.17732248186123259206.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: Add TI TPS389008


On Wed, 19 Mar 2025 19:02:29 +0200, Flaviu Nistor wrote:
> Add device tree bindings and an example for the
> TI TPS389008 voltage monitor.
> 
> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
> ---
>  .../bindings/hwmon/ti,tps389008.yaml          | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/ti,tps389008.example.dtb: /example-0/i2c/vmon@37: failed to match any schema with compatible: ['ti,tps389008', 'ti,tps389006', 'ti,tps389004']
Documentation/devicetree/bindings/hwmon/ti,tps389008.example.dtb: /example-0/i2c/vmon@37: failed to match any schema with compatible: ['ti,tps389008', 'ti,tps389006', 'ti,tps389004']
Documentation/devicetree/bindings/hwmon/ti,tps389008.example.dtb: /example-0/i2c/vmon@37: failed to match any schema with compatible: ['ti,tps389008', 'ti,tps389006', 'ti,tps389004']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250319170234.63723-3-flaviu.nistor@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


