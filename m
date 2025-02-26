Return-Path: <linux-kernel+bounces-535156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295CA46F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349B216ABC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017A270053;
	Wed, 26 Feb 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMInkvyu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5527002B;
	Wed, 26 Feb 2025 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613405; cv=none; b=QKGtWnZ4IYYjsfoyWOYiXcVqeYMKTQEsa4sWG3+mKv4c7YYJY55Llj53rTW/Pit+52aYAmun5+hWrWjPimMGG9AmbhkHiNltrHoe76zOpDvrZVGRZ56qq0J89kcb8hPuI0FKs+6ue8DMgKRrhQ35ZD+9Jrn9cI2k/rJbN1A+Cxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613405; c=relaxed/simple;
	bh=W2ti+GhKV/TaogOnXMguMr6BVnRuQDgHB/rroxXI7mM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iKXyzBE7gOymKTaj01XCE1KF4K4ImDUdLo1PQwEqDAOJMvSXuUxSZLDHP9mKYANrhJ6Mz2cCaLKbuFjkm9NzN+J9VgupFd2CGotz2W2pAe/RO+CorQryYSnmCI9hzVGPVuWgXA56p2XasIWgCTYUYhqcmqyKmQIZoMuDntoVyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMInkvyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BBFC4CEE8;
	Wed, 26 Feb 2025 23:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740613405;
	bh=W2ti+GhKV/TaogOnXMguMr6BVnRuQDgHB/rroxXI7mM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kMInkvyu8UUVaKisY+qT4Kk7jwU97WiBEJn8rFuLEKplKRVscdi408gcseRWbgd5/
	 RCSmNUPHuXzNphgLdf+4dOx+c6JtT+/cOQV07iWG+4AeGLgzrlN9wmmnwDCcHl2C4y
	 NjzN1i9xqrzi4xgAcilCjwW8aYZOFGOzoyYzwAeQ8VCzTdnAPJd6naaxVzWU6FmmUU
	 bIEXc54g/EY6ION4B+gAUQbQkkT5hptLE7CZqtVBQrV/F3le7LBcBPzWtmN0QnV/We
	 FWMsQPZhsgORbo/MdbO+OuzffeR4b8E457TaoPoxz2JlthJXhp4he5FBzaG4NT5X0p
	 huuKxENYI5jLg==
Message-ID: <3364c2b6d3c1f22e1310464ae2a6f9a4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ed953445-9c55-4658-af16-04eaa71d746e@tuxon.dev>
References: <20190731193517.237136-1-sboyd@kernel.org> <20190731193517.237136-10-sboyd@kernel.org> <ed953445-9c55-4658-af16-04eaa71d746e@tuxon.dev>
Subject: Re: [PATCH 9/9] clk: Overwrite clk_hw::init with NULL during clk_register()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Doug Anderson <dianders@chromium.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 26 Feb 2025 15:43:22 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Claudiu Beznea (2025-02-15 05:55:51)
> Hi, Stephen,
>=20
> On 31.07.2019 22:35, Stephen Boyd wrote:
> > We don't want clk provider drivers to use the init structure after clk
> > registration time, but we leave a dangling reference to it by means of
> > clk_hw::init. Let's overwrite the member with NULL during clk_register()
> > so that this can't be used anymore after registration time.
> >=20
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index c0990703ce54..efac620264a2 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3566,6 +3566,14 @@ __clk_register(struct device *dev, struct device=
_node *np, struct clk_hw *hw)
> >  {
> >       int ret;
> >       struct clk_core *core;
> > +     const struct clk_init_data *init =3D hw->init;
> > +
> > +     /*
> > +      * The init data is not supposed to be used outside of registrati=
on path.
> > +      * Set it to NULL so that provider drivers can't use it either an=
d so that
> > +      * we catch use of hw->init early on in the core.
> > +      */
> > +     hw->init =3D NULL;
>=20
> I found that this line impact the drivers/clk/clk-versaclock3.c driver wh=
en
> doing unbind/bind. The driver provides statically initialized hw.init
> object for registration, the hw.init pointers are set to NULL after clock
> registrations then the next registration (when re-binding) fails.

That's nice </sarcasm>. Yeah I suspect a lot of drivers would fail if
they're unbound and rebound right now, for various reasons including
what you mention. I think Doug or Bjorn was concerned that this pointer
was left dangling when it could potentially lead to some driver
accessing the stack. That's what started the whole series.

> diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
> index 9fe27dace111..c1776c313e9b 100644
> --- a/drivers/clk/clk-versaclock3.c
> +++ b/drivers/clk/clk-versaclock3.c
> @@ -1068,7 +1069,7 @@ static int vc3_probe(struct i2c_client *client)
>                 ret =3D devm_clk_hw_register(dev, &clk_div[i].hw);
>                 if (ret)
>                         return dev_err_probe(dev, ret, "%s failed\n",
> -                                            clk_div[i].hw.init->name);
> +                                            "test");
> //clk_div[i].hw.init->name);
>         }
>=20
>         /* Register clk muxes */
> @@ -1082,7 +1083,7 @@ static int vc3_probe(struct i2c_client *client)
>                 ret =3D devm_clk_hw_register(dev, &clk_mux[i].hw);
>                 if (ret)
>                         return dev_err_probe(dev, ret, "%s failed\n",
> -                                            clk_mux[i].hw.init->name);
> +
> "test");//clk_mux[i].hw.init->name);
>         }
>=20
>         /* Register clk outputs */
>=20
> Can you please let me know if this is a wrong pattern? I noticed there are
> other drivers following similar approach, e.g.:
> - drivers/clk/clk-axm5516.c
> - drivers/clk/qcom/camcc-sm6350.c
> - drivers/clk/meson/c3-pll.c

Maybe we should only overwrite it to NULL when it succeeds. Or
inversely, restore the pointer when it fails so that drivers can print
the init->name. Of course, that doesn't fix the problem that a driver
may be stashing the init pointer in there anonymously, like the qcom
driver does.

Actually, I think what we want to do is pull that error message into
devm_clk_hw_register() and get rid of it everywhere else. Drivers will
still have to restore the pointer before registering if the driver is
unbound and bound. It isn't good to keep a pointer to the stack so I'd
like to keep the logic that knocks out the pointer.

---8<---
From: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: Print an error when clk registration fails

We have a lot of driver code that prints an error message when
registering a clk fails. Do that in the core function instead to
consolidate code. This also helps drivers avoid the anti-pattern of
accessing the struct clk_hw::init pointer after registration.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 50faafbf5dda..88edeae7a1f4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4397,6 +4397,13 @@ __clk_register(struct device *dev, struct device_nod=
e *np, struct clk_hw *hw)
 fail_name:
 	kref_put(&core->ref, __clk_release);
 fail_out:
+	if (dev) {
+		dev_err_probe(dev, ret, "failed to register clk '%s' (%pS)\n",
+			      init->name, hw);
+	} else {
+		pr_err("%pOF: error %pe: failed to register clk '%s' (%pS)\n",
+		       np, &ret, init->name, hw);
+	}
 	return ERR_PTR(ret);
 }
=20
--=20
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

