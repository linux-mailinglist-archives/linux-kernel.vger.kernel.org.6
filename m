Return-Path: <linux-kernel+bounces-512701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27697A33CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED073A337D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42997210F5B;
	Thu, 13 Feb 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+HX2z11"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7D202F8C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442749; cv=none; b=KGKJRVsgTwJXwTZF8Rljuv4DXqUuvioEUv+m4Vs9UOa/1AZQhTYBmj1JPjIAYVCieZ5myJtUkmxbsuGhKOd4AvcVMCw/xi4LSF67uTg+rg+VnPFpykyMUBtDr3SxEJHB0za0Fzkfe8n6rwArHXaRMpOaFW0kYM8rFof4e8JFCcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442749; c=relaxed/simple;
	bh=RSb6AWuuOTKDXx/iwJOiFqPAdBRjDemlLkiLcOpxrPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyHy8YvIQacP/9JuNwhff799zSDi8XoH94TGKOEBRwp5ipP/mX6cieuslnE9bfnYfUsBcFuPGzZClkgCUG4QlqNlVZZK1UQwPtMirKMFF/LjPAhytRedbcvH7pITBBRO4xDrDmYfaMNYrSouHNfesjxa8ld7xiZKzKehcGwY9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+HX2z11; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739442746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
	b=c+HX2z11x9xj7CYcbhNfCg3vNanl9VP30+nVVfz7RmQU9A6J+OPWNV+djrxGUm/Mq+x6Yv
	rxAmaz7RotKy3AK9f6tT0GC5TTU+upfovhG0bKnPd9iw5xDn6epFk+lej88pl+N4DXUpf+
	CwVztTpzvcXc2Uh6lPxvuqAFiKRU78k=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aFXyvQdDNFm1UECbt88cjg-1; Thu, 13 Feb 2025 05:32:25 -0500
X-MC-Unique: aFXyvQdDNFm1UECbt88cjg-1
X-Mimecast-MFC-AGG-ID: aFXyvQdDNFm1UECbt88cjg
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5450eef8479so345478e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:32:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739442744; x=1740047544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft4Xrl2F2mgPSEHxN3B5fwyLk6cWe4p7NtJxQ7scBGU=;
        b=HVKOZWBQgtdP5o1G6xTZzBIc3bKQvUyt7LFXgt30kvydKgq+gAe+TX8NZayIpOxVhw
         9xBGDUxuUMnCecvo+1TZdgocRgf2N1udj2019tp94uF0Fwt3n7p6u9JntXm6fRXrGVSs
         R5uDjMhU5RoB33fxRoOUuOR55V6A75bo6FVQUlKbh+H1fOI5CGxS+7U4isdLta7Df8v9
         jMiy9fFlQnxYxPbshFhX23RmaYtH3Fn/kX5JnyM+stMGnjk95m+XH4r3GVzHitgUUqJo
         vi+MiyTPBhzQNQ89iJyUR0smbg9oZUPPMKm8VmKR8e/iW96gqW0bDtOnmumY2sLI7iDJ
         R1VA==
X-Forwarded-Encrypted: i=1; AJvYcCUlQKLuxyq1FiUc3/f+lbFwAb6vm1b3at5pYUnJzYcgPLcNN4ph7VHSOTbhblBt6Rs6RS1LiKT8u/w1AGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM0XIgA1IV7T8Joy7fLNXP8eyRO3eg/40bTnwkRYAPV00JUCrG
	MRGRTnBRK3e5ijvgSuWUZ+3BEf0m36whfpp1PU7Yq0hCD+CxATt0fSx6ybYqU8lxqTPhf+5JCwC
	LxZIRetVBltjqDks5031QRTjbtVgyGfB6hCYmzQ7qBbMGggUTN+aSt98ytejDNw==
X-Gm-Gg: ASbGncuMYC5xkteqitUOX1CMMzxMwXJhr8w6EqeSHsoTIzYPLC7OtDzykVDB7KNG23x
	Af0w6NKV4eIWkFQ5rPPdD5Lqmpmw0NoHrZdJWzcCLhhT4uuXAC0PqoMKFCvctoNE7u036zOW9Cv
	G8bjkPeAWK0NTj1KjOaxRbEIMHJzFIsgThgAVNRQGpSBRoj5sRQmLz2vrAi9GJldG4hmhDTopY6
	e6+d9XAQVyt3kcesuRdEdo7zaPv2evGy81ylQHIraQlxXh1FWu1/kcCZoDxJ6tJtz8tVcKQQxPO
	0D7oSR5aL7CUHSlYY4kWobDKozjnaNpARKs=
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313804e87.5.1739442743788;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOjVjfgWpSxlDgp1d5SSfQqcJAl+Kj/IMfKejulsNDq4Ht7M1ACB2G+v8WrXUKd+ndKzht2A==
X-Received: by 2002:a05:6512:1288:b0:542:8cf5:a3a3 with SMTP id 2adb3069b0e04-545180ea9bdmr2313793e87.5.1739442743361;
        Thu, 13 Feb 2025 02:32:23 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f083443sm131485e87.33.2025.02.13.02.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:32:22 -0800 (PST)
Message-ID: <875da042-ef68-4036-beab-9beff1e21ab7@redhat.com>
Date: Thu, 13 Feb 2025 11:32:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] octeontx2-af: Fix uninitialized scalar variable
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: hariprasad <hkelam@marvell.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250210-otx2_common-v1-1-954570a3666d@ethancedwards.com>
 <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Z6rk3Z6TuFSJgSaV@mev-dev.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/25 6:50 AM, Michal Swiatkowski wrote:
> On Mon, Feb 10, 2025 at 09:01:52PM -0500, Ethan Carter Edwards wrote:
>> The variable *max_mtu* is uninitialized in the function
>> otx2_get_max_mtu. It is only assigned in the if-statement, leaving the
>> possibility of returning an uninitialized value.
> 
> In which case? If rc == 0 at the end of the function max_mtu is set to
> custom value from HW. If rc != it will reach the if after goto label and
> set max_mtu to default.
> 
> In my opinion this change is good. It is easier to see that the variable
> is alwyas correct initialized, but I don't think it is a fix for real
> issue.

Yep, this is not a fix, the 'Fixes' tag should be dropped. Also I think
the external tool related tag should not be included.

IMHO have the `max_mtu = 1500` initialization nearby the related warning
is preferable.

Since this is a refactor, I would instead rewrite the relevant function
to be more readable and hopefully please the checker, something alike
the following (completely untested):

---
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..7f6c8945e1ef 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1915,42 +1915,37 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf)
 	mutex_lock(&pfvf->mbox.lock);

 	req = otx2_mbox_alloc_msg_nix_get_hw_info(&pfvf->mbox);
-	if (!req) {
-		rc =  -ENOMEM;
-		goto out;
-	}
+	if (!req)
+		goto fail;

 	rc = otx2_sync_mbox_msg(&pfvf->mbox);
-	if (!rc) {
-		rsp = (struct nix_hw_info *)
-		       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
-		if (IS_ERR(rsp)) {
-			rc = PTR_ERR(rsp);
-			goto out;
-		}
+	if (rc)
+		goto fail;
+	rsp = (struct nix_hw_info *)
+	       otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp))
+		goto fail;

-		/* HW counts VLAN insertion bytes (8 for double tag)
-		 * irrespective of whether SQE is requesting to insert VLAN
-		 * in the packet or not. Hence these 8 bytes have to be
-		 * discounted from max packet size otherwise HW will throw
-		 * SMQ errors
-		 */
-		max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;
+	/* HW counts VLAN insertion bytes (8 for double tag)
+	 * irrespective of whether SQE is requesting to insert VLAN
+	 * in the packet or not. Hence these 8 bytes have to be
+	 * discounted from max packet size otherwise HW will throw
+	 * SMQ errors
+	 */
+	max_mtu = rsp->max_mtu - 8 - OTX2_ETH_HLEN;

-		/* Also save DWRR MTU, needed for DWRR weight calculation */
-		pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
-		if (!pfvf->hw.dwrr_mtu)
-			pfvf->hw.dwrr_mtu = 1;
-	}
+	/* Also save DWRR MTU, needed for DWRR weight calculation */
+	pfvf->hw.dwrr_mtu = get_dwrr_mtu(pfvf, rsp);
+	if (!pfvf->hw.dwrr_mtu)
+		pfvf->hw.dwrr_mtu = 1;
+	mutex_unlock(&pfvf->mbox.lock);
+	return max_mtu;

-out:
+fail:
 	mutex_unlock(&pfvf->mbox.lock);
-	if (rc) {
-		dev_warn(pfvf->dev,
+	dev_warn(pfvf->dev,
 			 "Failed to get MTU from hardware setting default value(1500)\n");
-		max_mtu = 1500;
-	}
-	return max_mtu;
+	return 1500;
 }
 EXPORT_SYMBOL(otx2_get_max_mtu);



