Return-Path: <linux-kernel+bounces-349667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F61198F9D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04D028636F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286291CC883;
	Thu,  3 Oct 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="aAC2tybU"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A7D1CBE8B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994341; cv=none; b=LB2YeS4Pe8Kf7NvJKdF2Z9ryXTtU6otymcGiI287JQflNUEzdOGncCKbqb0FSQ0vNl7JBLoVzWb2qsTbI3t+wxXCHW9eICrsbf/fdX7/7Kk2f7Q35OpO5OhaPXgqLuGJhrnUux0pMnnm14QoyBSij4A6uKhN+NVovgX/obYb2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994341; c=relaxed/simple;
	bh=/tdPGKTRpyNy66gWpeoMRW/UZC0CGNA76S61xsVjTag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um621hfWL8YdloNOVvge2PE0MUr6e0yyp8K6ZlSa4odjyJLX2fTd56O34wnaBjPTC7Sd1Ye86eu+kmhUgrDzMJPxDEnuCO5s6XHuk8pPBIQqvXagQuVRwr8yLOmuqbbXgVRQtXeL9UHWUNnmFSprFmQk3NcYb4pe1U35pjm0tHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=aAC2tybU; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4585721f6edso10422341cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1727994339; x=1728599139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tdPGKTRpyNy66gWpeoMRW/UZC0CGNA76S61xsVjTag=;
        b=aAC2tybUHXDwuSSanJgkElVzybRheKli9iAmy2HsuBy19/RBg8oBifWbfh4FZgH1uD
         KeTfm6r5fsCbkXL0jUmnBkx1S+5Yf/iF+qJYINGV6vr+/dhSogH/Dsfx3/dILZH+fy1z
         V9K2zm+xKNgAnbyEr04wAwHud4f9PrPqPF1+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727994339; x=1728599139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tdPGKTRpyNy66gWpeoMRW/UZC0CGNA76S61xsVjTag=;
        b=KYi8XUh9sy5+b48b0k+YnYqcgpk7uQ9ZUKJwstGwr+mT/nhUQ4URYptA5FvpsthpQY
         Cqa/U0VZJU+DCaigRqzRjDzPYAiGRfBwE0SzHEWRfafeezx8JgA7pfOVbNtrkcKsxMKF
         RtmMnnt1Z0nKj9vWNV0Ls9rrKIvI1bA5HLqhAlQpxBAnoG9Hy6wPOfJlVgJOg6KN8OlU
         8HbuKRwDAFBxarxZXtE0DgJP9yvQwYv5c+fWa+sL6kk+2m7N4o7EgfZTZidcFZmlsNO6
         zJkfqXkXIKHxRVDhQIpp4wgPR4px2hADRHlK4/fLwTHLsVWShLqj8+ZIxtXWZg8Q9Zql
         GV7g==
X-Forwarded-Encrypted: i=1; AJvYcCXUeJJLxMiRZuN/rUoUYkpzCvZncs81SZeXdx7MwalbL0LKjeiH11xUF/up5Ocek+Zj7jGiCUBv/oAzSfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUsM/RojXsxBxGjvsOOuiDo9gbcczAxcYw30oUPEqNHqBueUVv
	0T4SvQvc/SXQl8l1oW7PWz4b93NxEAS7tJLNiC4KJsdVl2CeZBeupRDyL/GJva0=
X-Google-Smtp-Source: AGHT+IFtNEtUC6UYQ6GkzKNQoRDC09+X2lFVHE7Hq2fAJVteYHlZUFxRb/q69xK5TQcyuzeCzLuCYw==
X-Received: by 2002:ac8:5a87:0:b0:458:4b53:e0c6 with SMTP id d75a77b69052e-45d9ba630b3mr12099081cf.25.1727994338810;
        Thu, 03 Oct 2024 15:25:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45d92ed4f49sm9064321cf.67.2024.10.03.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:25:37 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:25:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 37/37] CI: Enable qemu_sbsa
Message-ID: <20241003222534.GX4737@bill-the-cat>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
 <20241002094832.24933-38-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3s5xTd89H/kNwgJ"
Content-Disposition: inline
In-Reply-To: <20241002094832.24933-38-patrick.rudolph@9elements.com>
X-Clacks-Overhead: GNU Terry Pratchett


--x3s5xTd89H/kNwgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2024 at 11:47:28AM +0200, Patrick Rudolph wrote:

> Add QEMU's SBSA ref board to azure pipelines and gitlab CI to run tests o=
n it.
> TEST: Run on Azure pipelines and confirmed that tests succeed.
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--x3s5xTd89H/kNwgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/Gd4ACgkQFHw5/5Y0
tyzJlAv/XVtUDkrEoATy2oY/uUiClHL3babaxYqMHBQrbPxHUTWK2OTH0A6rMvbj
WjFFNFCauVkM8Lg+pdjKoSBvNAmhDvl8pXLBhSX8hw6BkVEE6uenuTyQ9T820uPK
fMhIvL+akImmiCWtzMpjqJZoDSOc3dQ/C+sQVoRf7c5za3wMcc36ZXdJeC5XsX+H
IeMGKI+OPwA9tXllMp/MKUQ3a/A1SeERwvDMbsSYmqdInrUu6r/fXv71zfvUGme0
0/JBguK+qsNZ3t73fU3UvF1S1xX7NOEMvDNvIQkCfakC1xMyEm7TjPy3jS+jbCX6
6EpqbvRHJxhFKOcUxtZ+hnxmHeiOFXulKvjcwjx2iaq2yX5sta4q1qAGHEspjw+T
VitEwJUknjrj7pokXtaNA8bWCbSXWsjrM6kP4R8ExH0I02Qzh+iDcSbqP5dL7j3b
SkDGnVbIMRVxSbNssrjG2c/424rjS6/MtSeqimRhkQweKhkNe2qipfac7Ly0umaA
NQdlH+5x
=7jF3
-----END PGP SIGNATURE-----

--x3s5xTd89H/kNwgJ--

