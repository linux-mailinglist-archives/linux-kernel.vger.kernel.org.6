Return-Path: <linux-kernel+bounces-259300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3D9393B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548CB1C21643
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6E417166C;
	Mon, 22 Jul 2024 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD7ke6BJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE117277F;
	Mon, 22 Jul 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673702; cv=none; b=rrdjdGhNaAM5Qr94KVRhd0/D7m2qjN5eUyYgLhqfQrDaAXOAX5cPkXD9LEV7GnBJa9zBhr62QQ0lCScCF8k5LHcZ7zNApH7repQdDu4vwAcYy7gFaAJKO0LsORYY8AOKHftNidrYbbsSvgQHySRFMWSEYu9FKpiAh3aydkO7PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673702; c=relaxed/simple;
	bh=vxkBtcXPflRKx6JflN6P2jLEpplVf/tdl4WD1koeSng=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jk81nDASK7hdQTJQJAheGlcT4u8PY10RCuQ2iEeclHnlao0Pjqw0GNFYpbVld3qZZt0bLNdQONqQ0X4mTzsXtVcuzq9b+UeuWdoZ5QLGMhczE80lGP0Eobw1UAbcGQ++tqhCBH5OgIsunRJ1xg+lQUpDzgqkIUyJvoz6HjD1K1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD7ke6BJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD729C116B1;
	Mon, 22 Jul 2024 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721673702;
	bh=vxkBtcXPflRKx6JflN6P2jLEpplVf/tdl4WD1koeSng=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GD7ke6BJQ4NvY7j0sAZzg9/fN3sV6Tl43el4L6r5vFEcCkUPDydR7ShWtX7lexWLz
	 f0MToOwe3KWy7eZyfqfhLIQYYe8qtT8//yUHzKsceEFdJeMAAnjYqaH48jdlh4YTcM
	 xbndyQOrDs2HXYz7Uu2wlLK6VO+mLwJPp7BdqekeXgAwAML/Ytal+rzFjMOF8ml56m
	 wl6vXa1rlmmLZJhVXzwNP79nNCku3Nh6jCzqIChbFPb7AT3zApNRWRzrLMMD/zYASO
	 v3ynHY9xD5JUoi0LXFpoI1SpFoj+8paYTyUAsVnp+X93F+H8ef3d2AHov8HwvAsj95
	 R/bmwzI7YZXtw==
Date: Mon, 22 Jul 2024 12:41:38 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: ysionneau@kalrayinc.com
Cc: Jonathan Borne <jborne@kalrayinc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Julian Vetter <jvetter@kalrayinc.com>, 
 Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <20240722094226.21602-9-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-9-ysionneau@kalrayinc.com>
Message-Id: <172167366276.4638.3235725980067495299.robh@kernel.org>
Subject: Re: [RFC PATCH v3 08/37] dt-bindings: Add binding for
 kalray,coolidge-dsu-clock


On Mon, 22 Jul 2024 11:41:19 +0200, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
> 
> Add binding for Kalray Coolidge DSU (Debug System Unit) clock.
> 
> Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
> ---
> 
> Notes:
> 
> V2 -> V3: New patch
> ---
>  .../clock/kalray,coolidge-dsu-clock.yaml      | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/kalray,coolidge-dsu-clock.example.dtb: dsu_clock@a44180: reg: [[0, 10764672], [0, 8]] is too long
	from schema $id: http://devicetree.org/schemas/clock/kalray,coolidge-dsu-clock.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240722094226.21602-9-ysionneau@kalrayinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


