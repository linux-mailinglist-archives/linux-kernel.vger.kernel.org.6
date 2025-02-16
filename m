Return-Path: <linux-kernel+bounces-516853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2157A37840
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D268A7A1B12
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1991A3164;
	Sun, 16 Feb 2025 23:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z495jLHd"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB2CC2EF
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739746943; cv=none; b=pCoBcSSSD1VCJArTvEds9BQ+THbukbJrtahGGGg4ipRd584ztvnhjuWodlF/Tx21t0zFHaxP8/VYieGptwqTz2gz+kwWqLwX4pAKgiZ2kKgwcnczyvSKUWW3MxSI4e1W+ObqSCX+ZjbbL4NchfHGz7/26Pnqz4V3YWqSr7VEcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739746943; c=relaxed/simple;
	bh=xiWjpdFF9XPpfEzPoyR7xsudrR7wH3BjMki1l9XEEus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KGBBASOryKVrTjwS9VkrZs4/5OHQpXqyUBnCJWqHqAHouaVmPWLytOUh4vNG0PMupiUDKyQ5umt/XEOJNG3AIjYak9hnyUeb5XLwcVe94t0vsjGbQSRdYtZ1HMr3PCgF3rZdSqBc0JXk6h29l8sEFJ1R+cY0sK7/ThpZQhal2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z495jLHd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so4589097a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739746940; x=1740351740; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pULEHnKU9mg3MmXXhbc40zoqPwIpVwyHncuHvzBebGo=;
        b=Z495jLHdL5hQ6Imrtb8Xa6anFrAqYfMYKlPS7/zeayFv3qrKF55xZHSdL5Xt/iC1Fl
         bIU/Yd75xhiLfdPJwdkrlhmxLX7n5F1kE4vls21wCW4R6qhAjUWjL7D10kvgngcoTVPV
         ddp5vdJQuC8Z4+nBfNFCURO9hkAoQIcyVBQj8hUEXpkLF+g2DlqBIRHMArrhBQoZkBOA
         yVlV8htO5UkZaIisr2iAOsnDoWCC1KRO0n2KKGnCs9pLp6EHAvdL8IMMVr2VJoFWn7Tk
         6ftnvCvC/ON3EKniHqssdTnJZjbuAFz56zoBT2yCO0ApD34mI+j0AY5v/zF76cBQ55Np
         H7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739746940; x=1740351740;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pULEHnKU9mg3MmXXhbc40zoqPwIpVwyHncuHvzBebGo=;
        b=nwIp0PfN0HBeUgOlmYuNBPTNR8+QHya2WIjDFldQRQvDEmOGuSlUTI9/ATxq5L/Jzi
         nS8desCar0PamZQxCoAw1H5RYIbg3E0UYCU6WIilDcHDjGA8ra99WEhEhxND9di3bJUx
         aNvYIGjKsLnoOJcsbd5LMCDc9RVb4sBY86kcpwcizIW9jOrqgmOvjYz2yu43KkVEzr4t
         FJGtO7W2eVNqhpB53cWNFgBTA+DT+H9TF3vRFPYoRGKawxs6GCxHwH1FRWXd6gX5qCG6
         QNz1Gso5/KOfVBDU6RjKc0BefBjbyddEZVhhJvboHz+4qpoDC8aBY1LymlBRfocZ7Klx
         rGvA==
X-Gm-Message-State: AOJu0YzqaiLySLHJ3UhjmarppbgRhtR59x1QSwNy9EYG53M/Ebut2sSD
	QrZF2m8N6WYA6XZPyQkUz4m8pThUEWzatMtjLz9WJfgy6ezT6Hd9ve/mffn+ZcE=
X-Gm-Gg: ASbGncs5hefZJqgggNKqyY9ekfJwdFlUlnjKuuWg/cACmu+/kmuMYuuS+mc9nq436IS
	+tSO7zHDt2m4wNFf2LMxtTnggb+oUhehcqVY9+PtOSPMmcpG8iXYZZTYQZJ9Ffesc1D8GVR4/30
	A4k2pzb4jHT69CYGPmUKBd+uPvzaw5LTKgwBSak4SVIMry/WtXR5yCSmPBWvlVEh60TKWQaL4Ki
	ARVhBmRkGFt/N3JSaB93gWCcw7tG5KI0iB7YQ1Fc78Bv1z9VRqqSnxzcDTSHeZfWCi30lzFpues
	20Vw2i3hxYYvo2Mz5LTfjckrbJSFfTSV2k42Jr58632PPivVBVysu4a98X3EymHCJHs=
X-Google-Smtp-Source: AGHT+IEDhflJ8TI3JTu/3Qpma6Hf+3TN6GhltgTMaA6tvwex9j7VHTgILpfAos4CWIbCjd0k46sSLw==
X-Received: by 2002:a17:907:6d17:b0:ab6:df79:f577 with SMTP id a640c23a62f3a-abb7092f7bcmr701221266b.9.1739746939745;
        Sun, 16 Feb 2025 15:02:19 -0800 (PST)
Received: from localhost (tor-exit-38.for-privacy.net. [185.220.101.38])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb86c9320csm264451866b.55.2025.02.16.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 15:02:19 -0800 (PST)
Date: Mon, 17 Feb 2025 01:02:11 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Documentation: ABI: sysfs-class-tpm: Fix typo
Message-ID: <z45phn5t6hecgnxxoiujjxrhui4lctdnreryftlguuf3w4nmf2@wr7chdte6ip5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix typo in sysfs-class-tpm's Documentation.

Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
---
 Documentation/ABI/stable/sysfs-class-tpm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-class-tpm b/Documentation/ABI/stable/sysfs-class-tpm
index 411d5895bed4..272a63213934 100644
--- a/Documentation/ABI/stable/sysfs-class-tpm
+++ b/Documentation/ABI/stable/sysfs-class-tpm
@@ -115,7 +115,7 @@ Description:	The "pubek" property will return the TPM's public endorsement
 		is version 1.2, the pubek will not be available without the
 		owner's authorization. Since the TPM driver doesn't store any
 		secrets, it can't authorize its own request for the pubek,
-		making it unaccessible. The public endorsement key is gener-
+		making it inaccessible. The public endorsement key is gener-
 		ated at TPM manufacture time and exists for the life of the
 		chip.
 
-- 
2.47.2


