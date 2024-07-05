Return-Path: <linux-kernel+bounces-242217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A837892851C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5492B284198
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8414533A;
	Fri,  5 Jul 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QI0/mnsp"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8511135A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171840; cv=none; b=RsHcsW/WEGPg68yRvgTxefNy1SYFE4FRiGigG7sRK9XiqYFwUVFY9bNB/JclVSjiCqn7TKNTYGYrHMmmTPlCrz4yfrLZU8cGzuCiuNKKcvnRI+XNFABDJwrS+qOzfTW6YmBnikJyJzmK7Y+In5QpQ8KKNs0Lh7qnT8j+tWdSr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171840; c=relaxed/simple;
	bh=Y9A85uGiNuKmSQluXFakcDbz90Ffy/6QtGj2zmAQeNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1AXhdIJg7i5CjtYkH9AqZYKfHQyYpUwpRTgktZLzjAhAK7ZhHeCn4Yhk2ZgUsOtDd8QvdeMnzOmwEik4POz9iryZcyTRNrxw7zSIr+qmrlZGSsYl163lAGEAVHCOWZKkYPoeKwI9c+C/ER7p34nFnSbNLn0XtNVcfWz6ysx/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QI0/mnsp; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd80e55efso2396204e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720171835; x=1720776635; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cdO/uS9TwdQzATDumMNwCYuL6Gl0o0WmFiKQpsz4If0=;
        b=QI0/mnsp92x9obPjfHVodPHSHYu6OGvucZ/EBn0dItPIQO8hYRqp/D7h0S+7Lcf8/Y
         pQVJVlKv1VE6KLosHrm1+7DXxlhtO3ptJwXFpaDETVxEGvE5t1izuQ1RfVolAH6vQ5SL
         ct8rEgio6qvAyR5E4mePpAr66HmEc45NI7zPESaXc/yJVbgbTlOP9TAB6nJXpXOsdwxH
         Hob9X73FGbvrpIfKoZd4JJW/b3sfDi9t1o2wLSXAkrx8TNHmqqKn3esHqXO5ClC6Rbzj
         aoyFImxF1uhgO2ekzg5Ac3j+tf1l3Tx2zAWvrxiberC2lbz5YXTAf8pACM5KlzSIuJ/A
         2BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720171835; x=1720776635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdO/uS9TwdQzATDumMNwCYuL6Gl0o0WmFiKQpsz4If0=;
        b=iPd6M1fPnkvhu7ndRjKxWp01OIUXcbf8ZrXTs78BMT802z2iU9z32Jeq4xuRwnr20x
         mjhaqZp9PhHFCTjtz+SfZfjx1bGdFk77thQd4CKExAVkehcPGVUkUip8NF+uc1hlaJev
         XgwZho1a8NT1c5F0btbPOcHz9YaqFOhLqeYy96UHStJmaAMc+KiG83HTEjd6e2KcwRtV
         FebdkYwF8giJW0hWg+fO8v9ZMBqF/+tQ3XSZWDL47RO+Sv0qhPk5rTK8yX3iih5XouvN
         X9KZDlsgbxs0EA9YYt3TOgRpt+MkrpoBCAwsBH/+ycJID2qrHyFIbVmsq/OmVqtknWVv
         nH+A==
X-Forwarded-Encrypted: i=1; AJvYcCVVAVUGBQJ9kDCnmDmGiSJtwxZxyMZVt+0ln2DoYsdIOJbdjue0UUJ1hfrR0OETcHf1gY5lX2KDca/dfApqjjoYa1pwafhP6D5mrId+
X-Gm-Message-State: AOJu0YyuOjaG1LZmpcJObXf7mf3QmblaSYLY1HKrb9dEY0QAaQsOmEtY
	JbEAgqu1FWTIQg9xkbIbJDkbUC6D883a7O72mIIPMcnDLRhfTG8Hlo1f3VYQL9s=
X-Google-Smtp-Source: AGHT+IFFE9kRpbAbmriANJ/2OwvV5GqhlF4QJ9eP1RAen8KTIhyXDDz8eGqxCZVhyLRHHxO8rGKEEw==
X-Received: by 2002:ac2:5315:0:b0:52c:db76:2a7a with SMTP id 2adb3069b0e04-52ea0632597mr3371985e87.34.1720171834780;
        Fri, 05 Jul 2024 02:30:34 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aafba2cesm670009866b.93.2024.07.05.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:30:34 -0700 (PDT)
Date: Fri, 5 Jul 2024 11:30:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] pwm: core: Use str_plural() in pwm_seq_show()
Message-ID: <dvc257dkgpbxa7n43tqd6uin6hyyrwqreukozu63ldgufkr5td@unh7nmttomds>
References: <20240618075248.1325-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkxogwgvtjrgxprz"
Content-Disposition: inline
In-Reply-To: <20240618075248.1325-1-jiapeng.chong@linux.alibaba.com>


--fkxogwgvtjrgxprz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 03:52:48PM +0800, Jiapeng Chong wrote:
> Use existing str_plural() function rather than duplicating its
> implementation.
>=20
> ./drivers/pwm/core.c:1690:6-16: opportunity for str_plural(chip->npwm).
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D9352
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 5c1d20985148..141c5003b216 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -1687,7 +1687,7 @@ static int pwm_seq_show(struct seq_file *s, void *v)
>  		   (char *)s->private, chip->id,
>  		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-b=
us",
>  		   dev_name(pwmchip_parent(chip)), chip->npwm,
> -		   (chip->npwm !=3D 1) ? "s" : "");
> +		   str_plural(chip->npwm));
> =20
>  	pwm_dbg_show(chip, s);

I'm not convinced this change to be beneficial. Given that emitting npwm
doesn't add a valuable information[1], I tend to suggest instead:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5c1d20985148..fc7aa17dc6b5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1683,11 +1683,10 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip =3D v;
=20
-	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+	seq_printf(s, "%s%d: %s/%s\n",
 		   (char *)s->private, chip->id,
 		   pwmchip_parent(chip)->bus ? pwmchip_parent(chip)->bus->name : "no-bus=
",
-		   dev_name(pwmchip_parent(chip)), chip->npwm,
-		   (chip->npwm !=3D 1) ? "s" : "");
+		   dev_name(pwmchip_parent(chip)))
=20
 	pwm_dbg_show(chip, s);
=20

If you want to pick up on this, feel free to use this patch without
attribution.

Best regards
Uwe

[1] pwm_dbg_show() emits npwm lines, so the value can be determined
easily.

--fkxogwgvtjrgxprz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHvTYACgkQj4D7WH0S
/k7kdQf/WQwpNKImPI4crrRDXBJQGDCVcXKIzq5hX5frg+HN45tB7g927yYJ6Oef
jINsn4cH8RsNL2D//jz3tJzlmK0g/noZ8/pHOI/hXNbWjZQBXjPzKwCVb+etswow
2NUN7udIkRUR6dOkb04zPD3B+9FnpSTw8zZN++swjWvYDjnYkzav7IC4QQx/PISz
zM4Qq9gg20193QJG3Gs9Fmdhcofj58SnQGtKHvUNw7xTrXg11kBbkCQxdTe68F4W
sIjvfFeYATEHYgUne3O3iH20HRSDgF96/6S8J40CvsjVYRfmRtvCO7hPNQmemNxr
dJOxStpL+CfxL0NUaJaozxizybtK1w==
=596V
-----END PGP SIGNATURE-----

--fkxogwgvtjrgxprz--

