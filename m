Return-Path: <linux-kernel+bounces-568206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF512A691FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B90A4261B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16901DA112;
	Wed, 19 Mar 2025 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD+Xnpp2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA3B15ECD7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395550; cv=none; b=JY2MRy3c8VASm7BDfqxXZzOKxdqb9oBsOl3icOaWkCVw8m10ofqp3bvgcRccZIHpsRYSy3SVlOKg980N3ThFr8XSVBiI6eo8MFGqB949wk4eHuf/+EoqWxXcRrcv23EuhgyP2tpW4/HHa5srWwPC5w/gaII3pIZcta/6wxTUBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395550; c=relaxed/simple;
	bh=9L42q8XTVysN7xQfFBqQBdxnATYp/dyhFwRQkVx/X5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csTZXDz/B2d8cr6+Zzxe/Dd1PrH5vClkwuhhuhqc+RX51oD+c3ZovP135XJgOHgy4cY+/aBj3NNT7cSlayq846cPqRoAoz2gKRxETaErBxoQ570EbvNRoeHdK2bxyDrTPDoOXmIcEUyzrE2rZrjIieFOfatUlIXPwBON4UYiqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AD+Xnpp2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742395547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uivH8PibG1oy7GS5DqSAMDJAw4T7tHzPmVv8sb0Gz0=;
	b=AD+Xnpp27vro/KWmHPkQmHAXc9gVfjqvFFGr2y4viemrM9j17Yjq0sUenTqbQv1yCg6LZN
	hHXOZpAtOIFoczn4Df/Lg3KfdAljm4rC0QyinxqnY4BzEI4vdLtF7Z4ZJnPqF3VkIlq6rV
	jJvXyiCQOfIzsMrZJd9YvaUZvGKA2rs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-fLmtmA2ZMrOqMbCQhvgAjw-1; Wed, 19 Mar 2025 10:45:45 -0400
X-MC-Unique: fLmtmA2ZMrOqMbCQhvgAjw-1
X-Mimecast-MFC-AGG-ID: fLmtmA2ZMrOqMbCQhvgAjw_1742395544
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso3934951f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395544; x=1743000344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uivH8PibG1oy7GS5DqSAMDJAw4T7tHzPmVv8sb0Gz0=;
        b=GGCqBtONtVMyv14TkKNd+CeOdET6RrIs4LZf5t696v4hq4x0+qugLvGE0jXKMghk2U
         XcRrHMH8lqQQBZFlbMMM3tLyOfoXXyi0VSaXEBog+YxxfAF+N0I4Mcq9pqF/yMs609wX
         +r+s+lct9Qn7YmhEzbRdwbuvB4PHsK4x3vgJnm62dQDHv38vcZILrm0GdRzheK71OfDH
         83UJB6kxWNf7eTXPkX31nhIcEMJZ4OyiiAXUwugamjm6K09XDZrsq9NZM//A5+uLRJSD
         EyuGfdePf87IXvCzQ8NNGu/0JvcOxYvKJwbS4/f55aCraykxYryVsRw/vdv3c5BO1O8+
         CF3w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ78qsWjEiEoPVjiasT7Z5ahx7hnL0gPRPR+0Ig/AuCEE4NJzH6Qhqepwv/SEzZCCfx8QmO38Lw34G4Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfH8IBhlJjeUAj/f0raSGGdvbE8OgaD1TN2jW38dGNNYXEBUVC
	Pl3WrPBMmqth4/ml2D7DpANi+LQlsdH+veD1kAcehgXmZ8lzFjx4edYbyidrKo+SGTueNTVq7q9
	gqdxPpok6F8U3tiyV+fmf/wwPRHmUpcZPskXL2nHWYm14+P0fhexKxrpkXRXaXA==
X-Gm-Gg: ASbGncs2eMEJsXDBXje3la18R+O0SOnaFPdLjWsYqBy1Oj7cnLX81dUtfhgmCPvQVv5
	HTqryoAAvkMgbzB3Dm2uRKGBJPtW8LmFdcc1oe4vlVXNSlJ3SSv+fQRSvtfMjpx//joeMQTf8F5
	vQv0Vx0MppqP0Prg+4jpaI+EJ8ryl4zivfSMMgzwB7AWIiD3DAbdONNa6toHNDllGuIRZJdKNYz
	FKn/jNsKR7kuJYv5Rg43roi/FMcLQ3makXXrUpxUjxf+KDCicWzUBttDYKACtQ3IfVt7FQsu2Nk
	Nr8FBtyF6VNNSC3hPNPa8l4MGxc=
X-Received: by 2002:a05:6000:1882:b0:391:45e9:face with SMTP id ffacd0b85a97d-39973b42580mr2717386f8f.54.1742395544461;
        Wed, 19 Mar 2025 07:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMTYIXhBJfy97j/7DcnGLMwHyGymMh+1VfCo0umRZJg9WuviL2+KVtrXsPj1uih+w+iQXU0g==
X-Received: by 2002:a05:6000:1882:b0:391:45e9:face with SMTP id ffacd0b85a97d-39973b42580mr2717360f8f.54.1742395543947;
        Wed, 19 Mar 2025 07:45:43 -0700 (PDT)
Received: from t14s (109-81-85-212.rct.o2.cz. [109.81.85.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47bccsm20824965e9.15.2025.03.19.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:45:43 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:44:19 +0100
From: Jan Stancek <jstancek@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	R Nageswara Sastry <rnsastry@linux.ibm.com>,
	Neal Gompa <neal@gompa.dev>
Subject: Re: [PATCH 6.1&6.6 V3 3/3] sign-file,extract-cert: use pkcs11
 provider for OPENSSL MAJOR >= 3
Message-ID: <Z9rYQy3l5V5cvW7W@t14s>
References: <20250319064031.2971073-1-chenhuacai@loongson.cn>
 <20250319064031.2971073-4-chenhuacai@loongson.cn>
 <2025031943-disparity-dash-cfa3@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025031943-disparity-dash-cfa3@gregkh>

On Wed, Mar 19, 2025 at 07:13:13AM -0700, Greg Kroah-Hartman wrote:
>On Wed, Mar 19, 2025 at 02:40:31PM +0800, Huacai Chen wrote:
>> From: Jan Stancek <jstancek@redhat.com>
>>
>> commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.
>>
>> ENGINE API has been deprecated since OpenSSL version 3.0 [1].
>> Distros have started dropping support from headers and in future
>> it will likely disappear also from library.
>>
>> It has been superseded by the PROVIDER API, so use it instead
>> for OPENSSL MAJOR >= 3.
>>
>> [1] https://github.com/openssl/openssl/blob/master/README-ENGINES.md
>>
>> [jarkko: fixed up alignment issues reported by checkpatch.pl --strict]
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>>  certs/extract-cert.c | 103 ++++++++++++++++++++++++++++++-------------
>>  scripts/sign-file.c  |  93 ++++++++++++++++++++++++++------------
>>  2 files changed, 138 insertions(+), 58 deletions(-)
>
>This seems to differ from what is upstream by a lot, please document
>what you changed from it and why when you resend this series again.

Hunks are arranged differently, but code appears to be identical.
When I apply the series to v6.6.83 and compare with upstream I get:

$ git range-diff HEAD~3..HEAD 558bdc45dfb2~3..558bdc45dfb2
1:  02ea9f7368c6 ! 1:  300e6d4116f9 sign-file,extract-cert: move common SSL helper functions to a header
     @@ Metadata
       ## Commit message ##
          sign-file,extract-cert: move common SSL helper functions to a header

     -    commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.
     -
          Couple error handling helpers are repeated in both tools, so
          move them to a common header.

     @@ Commit message
          Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
          Reviewed-by: Neal Gompa <neal@gompa.dev>
          Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
     -    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

       ## MAINTAINERS ##
      @@ MAINTAINERS: S: Maintained
2:  0a81fb059cfd ! 2:  467d60eddf55 sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
     @@ Metadata
       ## Commit message ##
          sign-file,extract-cert: avoid using deprecated ERR_get_error_line()

     -    commit 467d60eddf55588add232feda325da7215ddaf30 upstream.
     -
          ERR_get_error_line() is deprecated since OpenSSL 3.0.

          Use ERR_peek_error_line() instead, and combine display_openssl_errors()
     @@ Commit message
          Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
          Reviewed-by: Neal Gompa <neal@gompa.dev>
          Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
     -    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

       ## certs/extract-cert.c ##
      @@ certs/extract-cert.c: int main(int argc, char **argv)
3:  0882f379a1f5 ! 3:  558bdc45dfb2 sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3
     @@ Metadata
       ## Commit message ##
          sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3

     -    commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.
     -
          ENGINE API has been deprecated since OpenSSL version 3.0 [1].
          Distros have started dropping support from headers and in future
          it will likely disappear also from library.
     @@ Commit message
          Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
          Reviewed-by: Neal Gompa <neal@gompa.dev>
          Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
     -    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

       ## certs/extract-cert.c ##
      @@

Regards,
Jan


