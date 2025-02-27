Return-Path: <linux-kernel+bounces-535253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF879A4709C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B8D188CF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95108C11;
	Thu, 27 Feb 2025 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEoozr81"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21611ECF;
	Thu, 27 Feb 2025 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618068; cv=none; b=jPeH7tKqZ+FETKz+7tSkmVtw1d+Y+sn1t4orDxC3sSzJWAhEG4DSm0TDBxCtWKV5oUEepPfoqeFiCv1o8Ayw+lsSyZhUg1wVw+m/wTyw9ExrpXymkp0H9yDA+Z/I0BZanZlLTz0EPHthHgapbBiyeZH3LkHCN8cuTOiphGNCQFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618068; c=relaxed/simple;
	bh=Az777yEEvc7WNpZb40fbFEenMSc4zBZXmQAQcH1+SrQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tgPlKfhoojEpyiwWqCPNrMHPqzUzeAa1GkU6he2QTrPAsVs4UEeqIZQy0Yd5e2KagJ7/r2ScqzHrql5HK2NLJZt0xbmzkYYKuTRSUMgGayYojB/GXNHMMMSdQaKTamfhB6sSN7Z5noprX9EqQ0QXqyhVM0Xyr4kswYfeDKeaQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEoozr81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80005C4CED6;
	Thu, 27 Feb 2025 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740618067;
	bh=Az777yEEvc7WNpZb40fbFEenMSc4zBZXmQAQcH1+SrQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UEoozr8165xSjeMQKQpHvilejSkF7ea3Evo63RS/b9hp3roHeAtHLM3EhZvbJAqZc
	 ogsNHvfZkdDdUo512fRWHvJyCZ8xuJidSuDJ8U4BZDu2QuwJMdEiObzsSk6Jr8ZQsi
	 j20E00sXJMW+XIbcf0hVNWofIDMzYCp8IYWI476UjJIgk/5Ni3sLFuTf87hiIPlyoM
	 9xAU/STIgTuk1r4tMsLVY6Hg8RZfMh7lp3EnonkYI8keB5Oe/z+RID4RP6Minkwt27
	 lG2OAX/8r5aaEpo8/h+fwQFAhUVFfyZFKQM7gzfN4xNShYb2XV6D7arhChHX/q0pos
	 8rh0QumR10lFQ==
Message-ID: <508a5ee6c6b365e8d9cdefd5a9eec769.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250120-amlogic-clk-drop-clk-regmap-tables-v3-1-126244146947@baylibre.com>
References: <20250120-amlogic-clk-drop-clk-regmap-tables-v3-0-126244146947@baylibre.com> <20250120-amlogic-clk-drop-clk-regmap-tables-v3-1-126244146947@baylibre.com>
Subject: Re: [PATCH v3 1/4] clk: add a clk_hw helpers to get the clock device or device_node
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 26 Feb 2025 17:01:05 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Jerome Brunet (2025-01-20 09:15:30)
> Add helpers to get the device or device_node associated with clk_hw.
>=20
> This can be used by clock drivers to access various device related
> functionality such as devres, dev_ prints, etc ...
>=20
> Add test for these new helpers in clk-test.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Thanks for adding tests!

> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 9b45fa005030f56e1478b9742715ebcde898133f..9818f87c1c56ab9a3782c2fd5=
5d3f602041769c3 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -365,6 +365,39 @@ const char *clk_hw_get_name(const struct clk_hw *hw)
>  }
>  EXPORT_SYMBOL_GPL(clk_hw_get_name);
> =20
> +/**
> + * clk_hw_get_dev - get device from an hardware clock.

Please add () to indicate function.

> + * @hw: the clk_hw pointer to get the struct device from
> + *
> + * This is a helper to get the struct device associated with a hardware
> + * clock. Some clocks, such as the ones registered from an early clock
> + * controller, may not be associated with any struct device.

Maybe write out that an 'early clock controller' is one that registers
clks with CLK_OF_DECLARE() or otherwise didn't pass a device pointer
while registering the clk.

> + *
> + * Return: the struct device associated with the clock, or NULL if there
> + * is none.
> + */
> +struct device *clk_hw_get_dev(const struct clk_hw *hw)
> +{
> +       return hw->core->dev;

Maybe we should increment the device refcount and require callers to
put_device(). Now's our chance to make the change!

> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_dev);
> +
> +/**
> + * clk_hw_get_of_node - get device_node from an hardware clock.

'from a hardware' and remove the period.

> + * @hw: the clk_hw pointer to get the struct device_node from
> + *
> + * This is a helper to get the struct device_node associated with an
> + * hardware clock.
> + *
> + * Return: the struct device_node associated with the clock, or NULL
> + * if there is none.
> + */

Can you put the kernel-doc in the header prototype? I want to move all
the comments there so we can include the header in the rst doc file with
the header 'clk provider API' or something like that.

> +struct device_node *clk_hw_get_of_node(const struct clk_hw *hw)
> +{
> +       return hw->core->of_node;

Maybe we should increment the of_node refcount and require callers to
of_node_put(). Now's our chance to make the change!

> +}
> +EXPORT_SYMBOL_GPL(clk_hw_get_of_node);
> +
>  struct clk_hw *__clk_get_hw(struct clk *clk)
>  {
>         return !clk ? NULL : clk->core->hw;
> diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
> index f08feeaa3750bc86859294650de298762dea690a..4dcdde283598b7f940c653ebc=
0d5a5f4c27637a2 100644
> --- a/drivers/clk/clk_test.c
> +++ b/drivers/clk/clk_test.c
> @@ -3077,6 +3084,80 @@ static struct kunit_suite clk_register_clk_parent_=
data_device_suite =3D {
>         .test_cases =3D clk_register_clk_parent_data_device_test_cases,
>  };
> =20
> +static void clk_register_dummy_device_driver(struct kunit *test)
> +{
> +       static const struct of_device_id match_table[] =3D {
> +               { .compatible =3D "test,clk-dummy-device" },
> +               { }
> +       };
> +
> +       clk_register_of_device_driver(test, match_table);
> +}
> +
> +/*
> + * Test that a clk registered with a struct device can provide back the
> + * struct device it was registered with.
> + */
> +static void clk_hw_get_dev_test(struct kunit *test)

The name of the test can tell us what it expects:

	clk_hw_get_dev_with_dev_gets_dev()
	clk_hw_get_dev_null_dev_gets_null()
	clk_hw_get_dev_with_node_gets_null() # this one uses of_clk_hw_register()
	clk_hw_get_of_node_with_dev_gets_node() # this one uses clk_hw_register()
	clk_hw_get_of_node_with_node_gets_node()
	clk_hw_get_of_node_null_node_gets_null()

I put some more test names. If we use gen params we can have spaces in
the name.

> +{
> +       struct clk_register_device_ctx *ctx;
> +
> +       ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +       test->priv =3D ctx;
> +
> +       clk_register_dummy_device_driver(test);
> +       ctx->hw.init =3D CLK_HW_INIT_NO_PARENT("test_get_dev",
> +                                            &clk_dummy_rate_ops, 0);
> +
> +       KUNIT_ASSERT_EQ(test, 0, clk_hw_register_kunit(test, ctx->dev, &c=
tx->hw));

Please put a newline between the assertions and the expectation. That
makes it easier to see at a glance what's expected by the test.

> +       KUNIT_EXPECT_PTR_EQ(test, ctx->dev, clk_hw_get_dev(&ctx->hw));
> +}
> +
> +/*
> + * Test that a clk registered with a struct device_node can provide back=
 the
> + * struct device_node it was registered with.
> + */
> +static void clk_hw_get_of_node_test(struct kunit *test)
> +{
> +       struct device_node *np;
> +       struct clk_hw *hw;
> +
> +       hw =3D kunit_kzalloc(test, sizeof(*hw), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
> +
> +       np =3D of_find_compatible_node(NULL, NULL, "test,clk-dummy-device=
");
> +       hw->init =3D CLK_HW_INIT_NO_PARENT("test_get_of_node",
> +                                        &clk_dummy_rate_ops, 0);
> +       of_node_put_kunit(test, np);
> +
> +       KUNIT_ASSERT_EQ(test, 0, of_clk_hw_register_kunit(test, np, hw));

The stuff before the expectation should likely go to the init function.
Or it can use the genparams stuff so we can set some struct members to
indicate if the pointer should be NULL or not and then twist through the
code a couple times.

> +       KUNIT_EXPECT_PTR_EQ(test, np, clk_hw_get_of_node(hw));
> +}
> +
> +static struct kunit_case clk_hw_test_cases[] =3D {
> +       KUNIT_CASE(clk_hw_get_dev_test),
> +       KUNIT_CASE(clk_hw_get_of_node_test),

Please add tests for the absence of the pointers.

> +       {}
> +};
> +
> +static int clk_hw_test_init(struct kunit *test)
> +{
> +       KUNIT_ASSERT_EQ(test, 0,
> +                       of_overlay_apply_kunit(test, kunit_clk_dummy_devi=
ce));
> +
> +       return 0;
> +}
> +
> +/*
> + * Test suite to verify the sanity clk_hw helper functions.

Test suite to verify clk_hw_get_dev() and clk_hw_get_of_node().

> + */
> +static struct kunit_suite clk_hw_test_suite =3D {

A better name is clk_hw_get_dev_of_node_suite

> +       .name =3D "clk_hw_test_suite",

Same, clk_hw_get_dev_of_node_suite.

> +       .init =3D clk_hw_test_init,
> +       .test_cases =3D clk_hw_test_cases,
> +};
> +
>  struct clk_assigned_rates_context {
>         struct clk_dummy_context clk0;
>         struct clk_dummy_context clk1;
> diff --git a/drivers/clk/kunit_clk_dummy_device.dtso b/drivers/clk/kunit_=
clk_dummy_device.dtso
> new file mode 100644
> index 0000000000000000000000000000000000000000..5cc89aa11264428b09e47fd29=
c5f9ecfb8c32fdd
> --- /dev/null
> +++ b/drivers/clk/kunit_clk_dummy_device.dtso

Ideally the name of the file gives a clue to the name of the test suite that
uses it. Perhaps kunit_clk_hw_get_dev_of_node.dtso is better.

> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +       kunit-clock-controller {
> +               compatible =3D "test,clk-dummy-device";

Maybe "test,clk-hw-get-dev-node".

> +               #clock-cells =3D <0>;
> +       };
> +};

