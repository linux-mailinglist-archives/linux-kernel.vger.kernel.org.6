Return-Path: <linux-kernel+bounces-284789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 481DD950526
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC50EB29444
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669DB1993A7;
	Tue, 13 Aug 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMWeaEa6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADD1607B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552521; cv=none; b=mWJb67VYzOnnwOg1fn9SQwFnGBeMHcQeEOIZDmiCgVIMt719bz24C2iOoTXUJUqqZ5SmPiHQVJVoIQs26iaUwtkQgjcABolTnxlpoXVIHIuS5o8Q9O2XyqraOQQK8XDnHxQKdisRArusCEK23skc9goUO2mEx9oFS9OYp4FQBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552521; c=relaxed/simple;
	bh=wmRroHD5OUg6Qf3agbFJLQGvx/qPAQPCOGwk3gK11LQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA7VfnDqtSLkQOFfTz9QJ+OaPh43NQQKndy+9FjOHFa1pPgM1bZXMmk0j3ASi2+ML3pRaqgxnxnvDiYeSo+k3jqdTev7PX7waakKc7xDVry2SsojL0N55RNnfXgFmtiFWbRhyJtZ+5qqH7KecYk4ljdP1H37xD9BZ+4LaQNd7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wMWeaEa6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368f92df172so2738415f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723552518; x=1724157318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XBmrpzh2TYDockOD1rtD5XC0eW7zgp6RoYkY7KL+LA=;
        b=wMWeaEa69pxs+2IALh0dIEP6tWG5RxqEm6qwlAhaDNb53iulQBAuiMJyqbmC5voIpV
         DXdY1ngFK8cLg9qhYdb4ehwjwGCi35My3WRmzhS9ZsNNPk2vT2T9hG7zlhbXNi5W9LBu
         1GK5gdyATIbgy+JhIazmEa+EIMrFJ9VUIYKf211w/s8ipauFSUkZTbjK5W1bqb0NIIQU
         YB3NkWTRyOafSkqfsJvnSq2mXbw69BURWy4P9AijWi85vPCxBsevq0nPhrBOwTlAl7Rz
         qLTbQ1mPBeKncmliyKWMvMx2Q2MYNCq9bSEES1Ql0GPNoUkbDQfEBRBcCFcQxvGVACC8
         e6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723552518; x=1724157318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XBmrpzh2TYDockOD1rtD5XC0eW7zgp6RoYkY7KL+LA=;
        b=oT+d+jerUJ85EK2QU0pOCUz0wbNbGayryW1jCFBWdHAksDDr3y0TE5izfFyA6TdkDT
         QAQOX/SOPH2t5DRN+QGb9JByDEGoaWligPmwb7HDH3zdAECCjaT61KdxNqQyffwiQzYM
         Dz3b2x0R8q9KLniKn2DPtENZUOLaIWXyWa3RiIT/WBJ78GllFrdanV30IkxaH7ibuTYT
         Q562o2BQRgsndBV6ZyTrG2aGXGxFG5rYyogL/c5XvFTRiQD9XsoyEruig09Urpc7r/yz
         tJzdhHG5GqywULXgGdBKD1NB0ZzXZudbc0Bz355q/twi10FlO8FOSUVfzI5lWvJV/oHe
         jT/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzNmElwYzsCOhfXgYqhQiIO0fXPhUPTk5O9GEWKJSOr3l2aTlfXXX+ZZ8TbCPyr5+p91ah6hdYIek2HLI5BkDzgb2Dd0TSmkQ+k+OS
X-Gm-Message-State: AOJu0YyzF3w8KM9pl/6X94x6lDRPdWHsPUhN9/Z/gASd8SsLAi8/NodI
	69y9LqlM2iXehRs7SjBh3TWsdj4WJHwebBNUAN5jfvPscOl8t5bllQeAn6/0Bvc=
X-Google-Smtp-Source: AGHT+IGo9esmOx/2Y4zteN5Z+67pxwJRzYVdBv5A9mVSlWCUku9O9x2DwsN2IM6SYDDbLve9RXqLiA==
X-Received: by 2002:adf:9b97:0:b0:362:4ce:2171 with SMTP id ffacd0b85a97d-3716cd25d65mr2050267f8f.52.1723552517534;
        Tue, 13 Aug 2024 05:35:17 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef22sm10160372f8f.52.2024.08.13.05.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 05:35:17 -0700 (PDT)
Message-ID: <69de592e-a3df-4fb3-ad0c-c8a44ae3efeb@linaro.org>
Date: Tue, 13 Aug 2024 13:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] media: qcom: camss: Add sm8550 support
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240812144131.369378-1-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2024 15:41, Depeng Shao wrote:
> v4:
> - Update dt-bindings based on comments - Krzysztof, bod, Vladimir
> - Move common code into csid core and vfe core driver - bod
> - Remove *_relaxed in the csid and vfe drivers - Krzysztof
> - Reorganize patches in logical junks, make sure that new added
> structures have users in current patch - Krzysztof
> - Remove notify function  and add new functions in camss for buf done
> and reg update - bod
> - Remove custom code to get csid base - bod
> - Remove ISR function in vfe780 driver since it is never fired - bod
> - Move csid_top_base to camss structure since we only have one csid
> top block, and just need to get base once for csid top
> - Add Vladimir's RB
> - Remove prerequisite-patch-id in the cover letter since the changes
> have been merged
> - Add dtsi patch link for reference - Krzysztof
> https://lore.kernel.org/all/20240807123333.2056518-1-quic_depengs@quicinc.com/
> - Link to v3: https://lore.kernel.org/all/20240709160656.31146-1-quic_depengs@quicinc.com/
> 
> v3:
> - Rebased the change based on below change which will be merged firstly.
> "Move camss version related defs in to resources"
> Link: https://lore.kernel.org/all/20240522154659.510-1-quic_grosikop@quicinc.com/
> - Rebased the change based on Bryan's csiphy optimization change and add
> these changes into this series, so that the new csiphy-3ph driver don't
> need to add duplicate code. This has got Bryan's permission to add his
> patches into this series.
> - Refactor some changes based on the comments to move the random code to
> patches where they are used.
> - Remove the vfe780 irq function since it isn't doing the actual work.
> - Add dt-binding for sm8550 camss driver.
> Link to V2: https://lore.kernel.org/all/20240320141136.26827-1-quic_depengs@quicinc.com/
> 
> v2:
> - Update some commit messages
> Link to V1: https://lore.kernel.org/all/20240320134227.16587-1-quic_depengs@quicinc.com/
> 
> v1:
> SM8550 is a Qualcomm flagship SoC. This series adds support to
> bring up the CSIPHY, CSID, VFE/RDI interfaces in SM8550.
> 
> SM8550 provides
> 
> - 3 x VFE, 3 RDI per VFE
> - 2 x VFE Lite, 4 RDI per VFE
> - 3 x CSID
> - 2 x CSID Lite
> - 8 x CSI PHY
> 
> ---

@Depeng.

Can you please fix the following checkpatch splats.

scripts/checkpatch.pl --strict *.patch

total: 0 errors, 0 warnings, 0 checks, 20 lines checked

0001-media-qcom-camss-csiphy-3ph-Fix-trivial-indentation-.patch has no 
obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 0 checks, 589 lines checked

0002-media-qcom-camss-csiphy-3ph-Remove-redundant-PHY-ini.patch has no 
obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 0 checks, 40 lines checked

0003-media-qcom-camss-csiphy-3ph-Rename-struct.patch has no obvious 
style problems and is ready for submission.
total: 0 errors, 0 warnings, 0 checks, 49 lines checked

0004-media-qcom-camss-csiphy-Add-an-init-callback-to-CSI-.patch has no 
obvious style problems and is ready for submission.
total: 0 errors, 0 warnings, 0 checks, 82 lines checked

0005-media-qcom-camss-csiphy-3ph-Move-CSIPHY-variables-to.patch has no 
obvious style problems and is ready for submission.
CHECK: Macro argument 'offset' may be better as '(offset)' to avoid 
precedence issues
#33: FILE: drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:45:
+#define CSIPHY_3PH_CMN_CSI_COMMON_CTRLn(offset, n)	(offset + 0x4 * (n))

CHECK: Macro argument 'offset' may be better as '(offset)' to avoid 
precedence issues
#38: FILE: drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:49:
+#define CSIPHY_3PH_CMN_CSI_COMMON_STATUSn(offset, n)	((offset + 0xb0) + 
0x4 * (n))

total: 0 errors, 0 warnings, 2 checks, 157 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0006-media-qcom-camss-csiphy-3ph-Use-an-offset-variable-t.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#19:
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 517 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0007-dt-bindings-media-camss-Add-qcom-sm8550-camss-bindin.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
CHECK: Alignment should match open parenthesis
#255: FILE: drivers/media/platform/qcom/camss/camss-csid.c:616:
+	dev_info(csid->camss->dev, "CSID:%d HW Version = %u.%u.%u\n",
+		csid->id, hw_gen, hw_rev, hw_step);

total: 0 errors, 0 warnings, 1 checks, 289 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0008-media-qcom-camss-csid-Move-common-code-into-csid-cor.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
CHECK: braces {} should be used on all arms of this statement
#677: FILE: drivers/media/platform/qcom/camss/camss-vfe.c:470:
+	if (output->buf[index]) {
[...]
+	} else
[...]

CHECK: Unbalanced braces around else statement
#682: FILE: drivers/media/platform/qcom/camss/camss-vfe.c:475:
+	} else

CHECK: Alignment should match open parenthesis
#775: FILE: drivers/media/platform/qcom/camss/camss-vfe.c:568:
+	if (output->state == VFE_OUTPUT_ON &&
+		output->gen2.active_num < 2) {

total: 0 errors, 0 warnings, 3 checks, 885 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0009-media-qcom-camss-vfe-Move-common-code-into-vfe-core.patch has style 
problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
total: 0 errors, 0 warnings, 0 checks, 67 lines checked

0010-media-qcom-camss-Add-sm8550-compatible.patch has no obvious style 
problems and is ready for submission.
0010-media-qcom-camss-Add-sm8550-compatible.patch:6: drvier ==> driver
total: 0 errors, 0 warnings, 0 checks, 253 lines checked

0011-media-qcom-camss-csiphy-3ph-Add-Gen2-v2.1.2-two-phas.patch has no 
obvious style problems and is ready for submission.
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#42:
new file mode 100644

CHECK: Please use a blank line after function/struct/union/enum declarations
#146: FILE: drivers/media/platform/qcom/camss/camss-csid-gen3.c:100:
+}
+#define REG_UPDATE_RDI			reg_update_rdi

CHECK: Alignment should match open parenthesis
#337: FILE: drivers/media/platform/qcom/camss/camss-csid-gen3.c:291:
+			writel(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
+						csid->base + CSID_BUF_DONE_IRQ_CLEAR);

CHECK: Alignment should match open parenthesis
#340: FILE: drivers/media/platform/qcom/camss/camss-csid-gen3.c:294:
+			writel(BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i),
+						csid->base + CSID_BUF_DONE_IRQ_MASK);

CHECK: Please don't use multiple blank lines
#412: FILE: drivers/media/platform/qcom/camss/camss-csid-gen3.h:21:
+
+

CHECK: Unnecessary parentheses around camss->vfe[hw_id]
#643: FILE: drivers/media/platform/qcom/camss/camss.c:1854:
+		vfe = &(camss->vfe[hw_id]);

total: 0 errors, 1 warnings, 5 checks, 607 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0012-media-qcom-camss-Add-CSID-Gen3-support-for-sm8550.patch has style 
problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#37:
new file mode 100644

CHECK: Alignment should match open parenthesis
#219: FILE: drivers/media/platform/qcom/camss/camss-vfe.c:684:
+		time = wait_for_completion_timeout(&vfe->reset_complete,
+			msecs_to_jiffies(VFE_RESET_TIMEOUT_MS));

CHECK: Unnecessary parentheses around camss->csid[hw_id]
#415: FILE: drivers/media/platform/qcom/camss/camss.c:1973:
+		csid = &(camss->csid[hw_id]);

total: 0 errors, 1 warnings, 2 checks, 388 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or 
--fix-inplace.

0013-media-qcom-camss-Add-support-for-VFE-hardware-versio.patch has 
style problems, please review.

NOTE: If any of the errors are false positives, please report
       them to the maintainer, see CHECKPATCH in MAINTAINERS.


---
bod

