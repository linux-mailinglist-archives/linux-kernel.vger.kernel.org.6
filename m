Return-Path: <linux-kernel+bounces-421858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 543599D9101
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A83228AD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 04:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9F130A7D;
	Tue, 26 Nov 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOSBmVd1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50742AA2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594800; cv=none; b=rXhq1cjSZxToJHH2tdNP6Ekz8+WECf69JdpOf+RomfUPV/rnZyQZXBJUA4QxBdhVd+i9Ibaz+qzzcRijtNR1sXb166+ePGlkM0Z3l5rdnUiYNiRO8KqIz26vN83Q8POKbBwM7eGAkBCCOAtXqNnj1mSt2IkAQyiymbJeXRIBYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594800; c=relaxed/simple;
	bh=5zVAkbu7TJnwT+KXgYyHDWMSKymFzOiIxz+xvgy4emw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABwmBaLulKWzcYCWuTPpMx3k1AqtgitZ7o4IHz6jEs0OHQoSFbad72HEFV+htjlDWYuLmVZSpzeQJ+lYb8H6K0ghVmMwNbVe/Nhu4UVXEPJyh8IwoaecLKjXYo5+h5eoOGp9sSEG4VO1uZIrU26U0nBQrs7l1GXV+pxtoM84Sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOSBmVd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91270C4CED0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732594798;
	bh=5zVAkbu7TJnwT+KXgYyHDWMSKymFzOiIxz+xvgy4emw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DOSBmVd13MrAI37ljg7fkpqOJ8y04GTlxk4jWgXx7DKx36qurdWVjWKp901fyUKdX
	 bsNe6D00fsn17lYebnExBATygzDE2qLfYz7WVVyqwhot0y9eYvHCT3vfvnBLjOwPnL
	 uWmqO5DyDoLhIIuv6kOnwL1/621+XAWXQleTaOa+sNzUcVSCOmae8UJg9/k5NmmEh9
	 Km3d8kQ/i4cyEOwIHlbeZWByANpkgswVH8RZN/Lh+pSjqJKw8oOyL2hx7/F3yJCq6B
	 BcJwSWbO/UgRaDPcgW3dGOBJSE91fNkpMWnzRn1WrEWLlYNXKmwZDP48wpx4P6vcBL
	 Lff4jCKxQnaLg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso2716260e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:19:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yz76IAr7I6hggrdqlCu7oXO8puWMnJvauAxPmuLik6ZtZiNq5Ey
	3Y46CBE0tnOMmLVYMuaM3hH7PKZGqOPuV5J0mxuC0ZTogN8IRaC/d0WFqEFBUWj4g7b/oOkiiIg
	Jsu0bduS4KYZ2OIPhK24N5QJUVmE=
X-Google-Smtp-Source: AGHT+IESHuLroU8rZwtuzByR/0SNVBecspvLNFcjitFZT6/NjPqvK+hX0Ou0sFlu/t+yU0IG6TWQmbmAN7Kpj4YjAyk=
X-Received: by 2002:a05:6512:3d89:b0:53d:df9b:ffb5 with SMTP id
 2adb3069b0e04-53ddf9c00bamr3399947e87.13.1732594797275; Mon, 25 Nov 2024
 20:19:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125083736.422081-1-lizhijian@fujitsu.com>
In-Reply-To: <20241125083736.422081-1-lizhijian@fujitsu.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Nov 2024 13:19:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLK2-KudkKTdHjbVVVf+DNnrSyRasgWiL9akszgggXuA@mail.gmail.com>
Message-ID: <CAK7LNATLK2-KudkKTdHjbVVVf+DNnrSyRasgWiL9akszgggXuA@mail.gmail.com>
Subject: Re: [PATCH v2] gitignore: Don't ignore 'tags' directory
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Kris Van Hees <kris.van.hees@oracle.com>, rostedt@goodmis.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 5:37=E2=80=AFPM Li Zhijian <lizhijian@fujitsu.com> =
wrote:
>
> LKP reported warnings [1] regarding files being ignored:


What I meant in the previous reply is LKP is unrelated
because "make W=3D1" is enough to reproduce these warnings.


Applied to linux-kbuild with the following simplified commit log.


    W=3D1 builds reported warnings regarding files being ignored:
         [ snip ]

    Although these files are tracked by Git and the warnings are false


Thanks.






>    tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one=
 of the .gitignore files
>    tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one o=
f the .gitignore files
>    tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by on=
e of the .gitignore files
>
> These warnings can be reproduced by compiling the kernel with the W=3D1 o=
ption.
> Although these files are tracked by Git and the warnings are false
> positives, adjusting the .gitignore entries will prevent these warnings a=
nd
> ensure a smoother script execution.
>
> [1] https://lore.kernel.org/linux-kselftest/202411251308.Vjm5MzVC-lkp@int=
el.com/
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 56972adb5031..6c57bb0259c6 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -128,6 +128,7 @@ series
>
>  # ctags files
>  tags
> +!tags/
>  TAGS
>
>  # cscope files
> --
> 2.44.0
>


--=20
Best Regards
Masahiro Yamada

