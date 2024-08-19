Return-Path: <linux-kernel+bounces-292663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD501957280
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0041C232C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2B3188CBD;
	Mon, 19 Aug 2024 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gofOoroL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C2D531;
	Mon, 19 Aug 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090109; cv=none; b=KasI/eytSOiEUdBczsw9oEk53aQQP6F0WSI+gqRrlEyGRhd4tMGIqJqdXLgglY9t0AkJp6dwjA3+kypehVAGg2fKqESuXbFNOZvRLgSBGy13+AywJvgsU0OTLBBSHYR9A0CsZSBpRVKz1SfOxF4w4pqFXOEtYWsEhEM1YLsP92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090109; c=relaxed/simple;
	bh=7x0iIF6GCUVRPy5nzbX6cI5y5zIem4xQ+4C0bBt//lI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bttoV9pxRA0NZCMIlEv/QORUS05CiCezAiZY8wDuiav9mTNgigYP+YHWgy1ti7jg0+M2rYquRvkGOFvOBe7nWuCo/GjpTj/Fs29mbjSbrDW7XBBgShIlZ85tYVbVKi1pzL1XLI+FW8k3El1Bxs6A75Q78qqrxmxcuwESDWe+DAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gofOoroL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9339C32782;
	Mon, 19 Aug 2024 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090108;
	bh=7x0iIF6GCUVRPy5nzbX6cI5y5zIem4xQ+4C0bBt//lI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gofOoroL/fanneRBrewSzF5e2iRJS86uJGlg2YjM47hiwmyahnUJAu+fM4Ia9EEIk
	 X+SPPeUP1PIZUCaHQagHjy9hbqFh1HJI7OzYD31+xo053ZzdeawYIcoCC6NpXs0DlS
	 XjmJuiMby/S2MUhZVjEX5ku5ZssW4Ad3dHKNHirCXF0Na5AZw2hQQQ2J/E4Y5EctyT
	 VMzNo15Le9UnT7FwPiqAVthIGSRlg+NBrXvVMpuIXF9vJLx/j5cGSnqi0E1o2JtlVx
	 aHvDlHHBd9Alupuydhx6zhgGwUz7q4yly5FVCS2uEV6KVxkW6MStUU+2hddfTg8uWx
	 CrGZNP849Fl7Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Aug 2024 20:55:04 +0300
Message-Id: <D3K2XNVHTEU0.WPUFQHKC3R22@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <zohar@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>, "Roberto Sassu"
 <roberto.sassu@huawei.com>
Subject: Re: [PATCH v2 01/14] mpi: Introduce mpi_key_length()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <dhowells@redhat.com>,
 <dwmw2@infradead.org>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
X-Mailer: aerc 0.18.2
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
 <20240818165756.629203-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240818165756.629203-2-roberto.sassu@huaweicloud.com>

On Sun Aug 18, 2024 at 7:57 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the new function to get the number of bits and bytes from an MP=
I.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  include/linux/mpi.h       |  2 ++
>  lib/crypto/mpi/mpicoder.c | 33 ++++++++++++++++++++++++++-------
>  2 files changed, 28 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/mpi.h b/include/linux/mpi.h
> index eb0d1c1db208..a7dd4c9d8120 100644
> --- a/include/linux/mpi.h
> +++ b/include/linux/mpi.h
> @@ -90,6 +90,8 @@ enum gcry_mpi_format {
>  };
> =20
>  MPI mpi_read_raw_data(const void *xbuffer, size_t nbytes);
> +int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
> +		   unsigned int *nbits_arg, unsigned int *nbytes_arg);
>  MPI mpi_read_from_buffer(const void *buffer, unsigned *ret_nread);
>  int mpi_fromstr(MPI val, const char *str);
>  MPI mpi_scanval(const char *string);
> diff --git a/lib/crypto/mpi/mpicoder.c b/lib/crypto/mpi/mpicoder.c
> index 3cb6bd148fa9..92447a1c8bf9 100644
> --- a/lib/crypto/mpi/mpicoder.c
> +++ b/lib/crypto/mpi/mpicoder.c
> @@ -79,22 +79,41 @@ MPI mpi_read_raw_data(const void *xbuffer, size_t nby=
tes)
>  }
>  EXPORT_SYMBOL_GPL(mpi_read_raw_data);
> =20
> -MPI mpi_read_from_buffer(const void *xbuffer, unsigned *ret_nread)
> +int mpi_key_length(const void *xbuffer, unsigned int ret_nread,
> +		   unsigned int *nbits_arg, unsigned int *nbytes_arg)
>  {
>  	const uint8_t *buffer =3D xbuffer;
> -	unsigned int nbits, nbytes;
> -	MPI val;
> +	unsigned int nbits;
> =20
> -	if (*ret_nread < 2)
> -		return ERR_PTR(-EINVAL);
> +	if (ret_nread < 2)
> +		return -EINVAL;
>  	nbits =3D buffer[0] << 8 | buffer[1];
> =20
>  	if (nbits > MAX_EXTERN_MPI_BITS) {
>  		pr_info("MPI: mpi too large (%u bits)\n", nbits);
> -		return ERR_PTR(-EINVAL);
> +		return -EINVAL;
>  	}
> =20
> -	nbytes =3D DIV_ROUND_UP(nbits, 8);
> +	if (nbits_arg)
> +		*nbits_arg =3D nbits;
> +	if (nbytes_arg)
> +		*nbytes_arg =3D DIV_ROUND_UP(nbits, 8);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mpi_key_length);
> +
> +MPI mpi_read_from_buffer(const void *xbuffer, unsigned int *ret_nread)
> +{
> +	const uint8_t *buffer =3D xbuffer;
> +	unsigned int nbytes;
> +	MPI val;
> +	int ret;
> +
> +	ret =3D mpi_key_length(xbuffer, *ret_nread, NULL, &nbytes);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
>  	if (nbytes + 2 > *ret_nread) {
>  		pr_info("MPI: mpi larger than buffer nbytes=3D%u ret_nread=3D%u\n",
>  				nbytes, *ret_nread);

Just double checked. Yeah, I don't think this belongs really to the
cover letter. Explaining the main goal gives the red line, so fix that
instead.

BR, Jarkko

