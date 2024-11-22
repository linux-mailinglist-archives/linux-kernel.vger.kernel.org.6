Return-Path: <linux-kernel+bounces-417875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49CB9D5A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11164282465
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0401741C6;
	Fri, 22 Nov 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XtwwI3Mx"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215713AA38
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261299; cv=none; b=POZTogXYjttp2KcjgOML39z2w+jB7J9a81jdyCncMTgcNiXDeOshOUHXJT2b66Y4FnR1dr7pBrgtbT/zzo6Su7Zad9bankl6tkfoOMZYpoNB18YzsC/kDxGkMM6fTCLBem72zb4kVf/PqXWoz8Jqs5KJJ0OhICdsVAwA2RKBwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261299; c=relaxed/simple;
	bh=cCF4a7xZu3k4CvCsXul+R4V71IZtblzB8rKccNz1NPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZNXmZfrj2SAXssCSAEkg1geMkTRfp/hNWV6vUzcrQisGD7Y+/v5wCHsgSwW23UyJJ2JIgxl1jlFXTDIqLFt2O/JV8dOpyf/WIGF/xt286rAFR/OArtTsruCEu1jWbuKRGM1KBhaMWM9xd0RmtTzoqK5sl5AYVcbz11M3Q7mCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XtwwI3Mx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so1987428a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732261295; x=1732866095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IBHoeELbwDLkucIgeo0FolILCzjYH65AZPyoPhvFLo0=;
        b=XtwwI3Mxg96IX/qvELbqS7p4QLfPdC+OmIIzaMz4Y3vAh4keeudrIpaJpRoFWNnZF5
         iVTu20eTWj915VZWmKgSeUTI7d69yTs4sr7z9J9fpS8ablS7XqRsOxLdccZDkoU+KdsW
         eyNasgujSd4E/GPxK/1Oe7hjUNIamEnqOTYD9KPWn1CGNxMDVvGKq9PGgv6oxXSRIOCS
         8KhegaE8dfWAPsivg/A+AYQTfFoEMlCz6bNGc+25CwJtoUVIEIT3Bq8knBE2x82kLdZK
         V9r7SDknVntFYUvNtb9i29hcH72/gJzw/dg2sFwGymccL3lNPTykQN0UZ5WDahJJ2o+j
         5JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261295; x=1732866095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBHoeELbwDLkucIgeo0FolILCzjYH65AZPyoPhvFLo0=;
        b=pLHCKszKhvE74LuhVy6kno++pG7RQoqTpuAe7AlNuVfIA1MQLSdUtx5N6ePeTZJj79
         lUIfUyle5eEpRyreBl4h/sKzEnu6ZaWOgKyNRBj72h48+epvilZZxZSWsPIB52pKNmop
         3xSGYNG64DVe2CSQ6htfhyESWpVvnyZgVRXM5dbdWvwa4hAllRYkN+aH81f8Doicpu/c
         BY/JdY2fKrXXYdOUrIS/qh6sC5o0d4hmDAQtfYPGtGyT31vf+IZXp3bOo66Mkl2P/Xrd
         ffy0EaNbDNzMh9YSNcl4Hg0tn4dWsNsBWDgJ2mChsUK6FoLZD6lTPY+Nn0DI1Z1qTvaw
         YJBw==
X-Forwarded-Encrypted: i=1; AJvYcCWHyXHuVbwKsj7MrfQ2G4XfY0EsYJl3lU8K/14YMBLtgWM6GHFpXxCbvTU9aS7AorQOAOeBtsbdkbwy7ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWk20fTwPpjMgz+mGxai8vHYz2SzokvecjF+RT5LZLjMPnlOT
	lp+Poy4uQf8uBg2fbNENKHgAd9VOCtDqCQ2pp9Q3IDw5S81aPk5sF1sVzzfyqe0=
X-Gm-Gg: ASbGncsmcZA0ixtK8gW7d8dn0v7QXGhnIzbKPTBIyC2Dz9arDHzXna8+5qqPp3cH/7h
	PA3/i5Et36R+I50sEG/RrawMS9t2Hvo6r4PkXWaKlyzBB2J0TOqjGQVf75cwTAHDemhDS6UVgln
	mgomvu8+58vqoRcdQkKxHFQ1CCR6E1mQWYshN5w5EhU9QrQ4BcMpP4Nq2x6TE5kmkd9L9XFkuWt
	lthE/8F5Um844/m6+2bATHR5c67W2dSbwwMmTQPWZqX2BNKvO/e2HSzImpG2ohH71l6CpUDcwOZ
	K7svZEyJbnzQ6VvMvWMkezmt34LxRJQJn1495PICkc/P+RUw2WegE41QHMQ0dfagehfYn+raQ/s
	=
X-Google-Smtp-Source: AGHT+IF52r/fIQbL1oofxnzTPJf9FWebVRq//EG7R9cwJOhSaBapeMtbsLC2alc3Bk+yr83btzoIrg==
X-Received: by 2002:a17:906:9d2:b0:aa4:fc7c:ea78 with SMTP id a640c23a62f3a-aa50997efb1mr140885766b.23.1732261295072;
        Thu, 21 Nov 2024 23:41:35 -0800 (PST)
Received: from ?IPV6:2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c? (p200300e5872eb100d3c7e0c05e3baa1c.dip0.t-ipconnect.de. [2003:e5:872e:b100:d3c7:e0c0:5e3b:aa1c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28fe1bsm66384366b.28.2024.11.21.23.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 23:41:34 -0800 (PST)
Message-ID: <f65fe715-2ef7-4171-8bae-b78438656dcf@suse.com>
Date: Fri, 22 Nov 2024 08:41:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p/xen: fix release of IRQ
To: Alexander Merritt <alexander@edera.dev>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Alex Zenla <alex@edera.dev>,
 Ariadne Conill <ariadne@ariadne.space>
References: <20241121225100.5736-1-alexander@edera.dev>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20241121225100.5736-1-alexander@edera.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 23:51, Alexander Merritt wrote:
> From: Alex Zenla <alex@edera.dev>
> 
> Kernel logs indicate an IRQ was double-freed.
> 
> Pass correct device ID during IRQ release.
> 
> Fixes: 71ebd71921e45 ("xen/9pfs: connect to the backend")
> Signed-off-by: Alex Zenla <alex@edera.dev>
> Signed-off-by: Alexander Merritt <alexander@edera.dev>
> Signed-off-by: Ariadne Conill <ariadne@ariadne.space>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

