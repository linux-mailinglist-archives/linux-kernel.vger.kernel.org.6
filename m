Return-Path: <linux-kernel+bounces-380464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61749AEF13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2419C1C22798
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F197D2003BC;
	Thu, 24 Oct 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="TMqUymJ2"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1E1FBF6A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792847; cv=none; b=sdErYj2P+27cDWxti9166J2Qt5v+MA7BWWdx2myoASKZajoq5DNAimOeR00F6x+IaBuogvmWYvd39uGP76/yPC5veSOvoYXc1u6vvaRpel7OcVpHIWvrLG6nalulUkVGN5jKKzUnbz1//fqilpl6MPrKHgCbe/NANmFTpgwuLdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792847; c=relaxed/simple;
	bh=muBTsnGgt4lv8pYJw02Ph/NywXN6cCSzdY71FcJMJg0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=caBdiq9whKP7lLxs6jRTRJBGHjn8NiqSgkpnAjtph0P1g1hLaWFYAcaqtf8O5nkRlwcEWkJweFh3WUg7LKaP7tjBBwRPr8a7mNu0GyHLXR1iRFzzB1rYR39OTiEItGyK8ae4rngbzcuiDJRnQcfeeGdfEu+b51GB09SIjjhavwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=TMqUymJ2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20bb39d97d1so9413865ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1729792844; x=1730397644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uq3Sx3k7CbWldci8VdjhK0lmnb+JNksv0KZ/tegkNgc=;
        b=TMqUymJ2N0LCY/YFINTOhn23AtuOAYUGk5I2CKnganONbFuIAHXjmsV5Dn4wxpJHjX
         PalXb69o2En9Jj9mxRpaNogtsapAJKsp8vzOrnLMFK1Guee3Iv2u82QPtpLjJymt0lJB
         CmRgHmwwu4TNe4wPrCs/5/o+6XF+2gXN0qixO2UK/ZTuO4Z8PEfigmQnAxm+B/tfjWND
         dXW/QdI/DC63k9jmFBXaBWvfMhiUs+6f8rUldsLScILzV4MRqWxbhPtaIt2GL4P/K2Es
         0H1NntOtXaiopuD6LA6N8XQZ4v9BGx97wNCHDYI3RciJ+fhpg7U2pQ88rrp2MfyARnUZ
         yNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792844; x=1730397644;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq3Sx3k7CbWldci8VdjhK0lmnb+JNksv0KZ/tegkNgc=;
        b=sUXdd6Vl4+jtCk5VvYrSUlrl7RUpVPOX+sTDnpzveNZX1cEk/tIW6ez+q/QRoeFdRf
         Aq2GDIvMPcwFtBLdN8i3kERavMAk4bI5R3PNUq+oavl4YviZCLTaBVqTo8FBm2XqZkRv
         p/zTWDc/aGQ1dPmV2qKoEFHEjSnN0jAUd3e1+ZmBCicWUCNo5zV7htHzI54SWEIbsKH+
         qWciqLyy10Qum9wsPt2W73xIz1phoXVSuPCrW49I6yOtTyEwSe5GNMhDKI3uTzeqldOe
         9FtBpLSX6zhV9kB54kKvU5p1LqjVIpg10N2tfyWxreFHugqc17Nu5d/ozLJdbRLsILqz
         F1BA==
X-Forwarded-Encrypted: i=1; AJvYcCVRfTEE41+3iLvrPo8B8k7bBrhUjdsMF3t3DJknlpgvENAbkwD9jL+qqUSTkSkVGnOwm3TfSfsc0j15MbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu38lP/LKNqo+0LIT2SM7B4i/9ymTGZ/GtsbvaU7eeGZLqDiBP
	3tCLBNsggHTN39IlAyRF/TR5MgD3uff9i9PB60AGYsITz7gQloYZgHqXQ6vMb7Q=
X-Google-Smtp-Source: AGHT+IG6scKr4Ed7CrsoFYPBrwdrqHCqMwM3BvTaed47lJT2cbMpV1ZnIibL+NTBPSm65i2rdkQzqw==
X-Received: by 2002:a17:902:e5ca:b0:20c:b876:5046 with SMTP id d9443c01a7336-20fa9ea37c0mr67231345ad.50.1729792844371;
        Thu, 24 Oct 2024 11:00:44 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef15992sm75616485ad.74.2024.10.24.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:00:43 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:00:43 -0700 (PDT)
X-Google-Original-Date: Thu, 24 Oct 2024 10:57:56 PDT (-0700)
Subject:     Re: [PATCH V2 3/4] selftest/mm: Fix typo in virtual_address_range
In-Reply-To: <20241008094141.549248-4-zhangchunyan@iscas.ac.cn>
CC: akpm@linux-foundation.org, shuah@kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, alex@ghiti.fr, Charlie Jenkins <charlie@rivosinc.com>, linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  zhang.lyra@gmail.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: zhangchunyan@iscas.ac.cn, akpm@linux-foundation.org
Message-ID: <mhng-43cbba56-67ba-4f5a-a929-0805662b22bf@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 02:41:40 PDT (-0700), zhangchunyan@iscas.ac.cn wrote:
> The function name should be *hint* address, so correct it.
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
> V1: https://lore.kernel.org/linux-mm/ZuOuedBpS7i3T%2Fo0@ghost/T/
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4e4c1e311247..2a2b69e91950 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -64,7 +64,7 @@
>  #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>  #endif
>
> -static char *hind_addr(void)
> +static char *hint_addr(void)
>  {
>  	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
>
> @@ -185,7 +185,7 @@ int main(int argc, char *argv[])
>  	}
>
>  	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
> -		hint = hind_addr();
> +		hint = hint_addr();
>  		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
>  			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

In case that helps, but this has nothing to do with RISC-V so you might 
need to re-send it so someone else notices.  Though +Andrew, in case 
that's enough...

