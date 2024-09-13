Return-Path: <linux-kernel+bounces-328056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F76977E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C121C22054
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A841D86EE;
	Fri, 13 Sep 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVnRmuEo"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA81865EC;
	Fri, 13 Sep 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226637; cv=none; b=juJ5q8P5gGm5T7vxIxBt9FZJCdJuj948uBCmZXgLghNcSAZS9sh+/O0A1Zpokcma9EoGNXcS9OFrU42B5h6wVtbai4+7YPzOXOK2re4Jnml8UPnItxczpWwLExnmFXQFKHNzNW/CAtQaz+4GPI0kS8AiRNGBKrJCWLLd3HwlXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226637; c=relaxed/simple;
	bh=b1eINWItUrz7LDBZEHNUq0MAEOSSnkBDteESNvjJXpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/BwzbU1wrAR+0SHfBEZXH7B73Q6WOv47YQDW/n1ZxiJEBDp3g5MlQpQNwO7VU9lhIE+H6sOw/Jvo5B5kO6xzbZW0Tu3bhFkjt5mVcN+cZgk+obcZTGWRNd0kebCzWD/GjL4IzoMOZI13x1DaVNWUdzWuqzTj2LOvOQGTnwv9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVnRmuEo; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3de13d6bdcaso695501b6e.2;
        Fri, 13 Sep 2024 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726226634; x=1726831434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gA9k/AHfPLIJ0mUGjEG4cSF4dJ9yRy6n+qpI/mOXskw=;
        b=lVnRmuEoPuVo12hK+GDJfqpoUKyWCMcUW5+6BImFQJozXo2JOBYmyAuD9cHMaVC95m
         1oKpPUI+VjtadtcalWKXB0I8vK1RPi63mMmlFCCqdYzs5r+3kQLD1/YzanpDNkAGlYn6
         rh5ODZJRfbJIqBWpfGyPjta4kNDbfdXi+aCdovEpmAJy0SjRRL4RHirg8q5KsgTmMFyf
         d71PK2oZ3BnPxTnumz3colRR/V70vTwdwC9kQciihkqdZdjXknOs1D+jHjTXwT/n/xRi
         ZyvDh/lGTlQkTcowt3670Dt7v7SkuSqDuhmbh309L+z25Z7fwQTXX3h42h5apadKptEW
         qXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726226634; x=1726831434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gA9k/AHfPLIJ0mUGjEG4cSF4dJ9yRy6n+qpI/mOXskw=;
        b=wQF8nPkYmlDQIzvacCkNcWLHyrt7s7l9fNfMr1IWaw40JdzLjg354Hu+Om+xX2skeF
         z8DKU5tEAEvWs3AwJhWzlJVRAVvsh9r5v822/e0q89x4PBf1COr2o3mAnk7VvqiRKoVI
         4V9BJ1jXOyftWrzYd5XLCdlCcLlPqbI4KfgcBLnJk/vecHRZwHGuX0LXYGnPrUzs6PsQ
         VM1IBSr1PaHbp4qlkOKCQns/3qDEovBLpZF7KMPV8tuPiigLcOUAe3EZxL3Td0ocmyRP
         BUZU0VMe1U66dHHEsuAjYTbzB+nJBrR+EZ5XyA9ukRd10SWswqrZFhX63PiSBut9ID1x
         A1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxvwOMy9bnXkBiUtI6ajhnPdnukK0qPfyz5U8U+gQ68apVYKpdmrpJISt3znEsjTCCDoGqLMquijk=@vger.kernel.org, AJvYcCVI2ts5fo4mEJ6WHzcpdks0iJFngr65BfD2URveR/bsUSbp33iaKsyqZl5e6Mw21bQbjB7B3pnmyglkMU+v@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN7qwb/txyu52UVXPB+QlHcLQpo4EuLSUu0NXZivqjCB3zl7O
	BfV88CYckgb1PlxnOzIIEz+lH6tOG0bC9n6UYVdlOp8150KRRNiCQgwFnf9/mY/4YDEIf4gHy6T
	CgkbZk7z6BLmFfy0nKgiTJU38MXw=
X-Google-Smtp-Source: AGHT+IEYyuKmqCz+O4Xn5NGCZZ9vljHnsVLhxqjd37Vao+yFjdFqgfjNZxvAy/L8jv/sbe1XGkuAQUlF5eXvLkWU5nU=
X-Received: by 2002:a05:6871:b1f:b0:277:bfee:33c0 with SMTP id
 586e51a60fabf-27c3ed56f98mr3945445fac.0.1726226634367; Fri, 13 Sep 2024
 04:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913081626.4174631-1-chengziqiu@hust.edu.cn>
In-Reply-To: <20240913081626.4174631-1-chengziqiu@hust.edu.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Fri, 13 Sep 2024 19:23:27 +0800
Message-ID: <CAD-N9QU5RA_z3pS3sGzXA_H=mHCDWyCCfDrv5JwL0hiAxx2qBQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: use ':Original:' tag to locate the origin file
To: Cheng Ziqiu <chengziqiu@hust.edu.cn>
Cc: Alex Shi <alexs@kernel.org>, YanTeng Si <si.yanteng@linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:17=E2=80=AFPM Cheng Ziqiu <chengziqiu@hust.edu.cn=
> wrote:
>
> Simply substitute path may cause file finding failed
> if we have a different dir map for translation. The
> ':Original:' tag could be used to locate the origin
> file if both the tag and file exist.

+cc yanteng's new email

>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---
>  scripts/checktransupdate.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/scripts/checktransupdate.py b/scripts/checktransupdate.py
> index 578c3fecfdfd..f28176691b03 100755
> --- a/scripts/checktransupdate.py
> +++ b/scripts/checktransupdate.py
> @@ -25,6 +25,7 @@ commit 42fb9cfd5b18 ("Documentation: dev-tools: Add lin=
k to RV docs")
>
>  import os
>  import time
> +import re
>  import logging
>  from argparse import ArgumentParser, ArgumentTypeError, BooleanOptionalA=
ction
>  from datetime import datetime
> @@ -32,6 +33,18 @@ from datetime import datetime
>
>  def get_origin_path(file_path):
>      """Get the origin path from the translation path"""
> +    with open(file_path, "r") as f:
> +        content =3D f.read()
> +    # find the origin path in the content
> +    match =3D re.search(r":Original:\s*(?::ref:`|:doc:`)?([^\s`]+)", con=
tent)
> +    if match:
> +        f =3D match.group(1)
> +        if os.path.exists(f):
> +            logging.debug("Origin tag found: %s", f)
> +            return f
> +        else:
> +            logging.warning("Origin tag found but file not exists: %s", =
f)
> +
>      paths =3D file_path.split("/")
>      tidx =3D paths.index("translations")
>      opaths =3D paths[:tidx]
> --
> 2.34.1
>
>

