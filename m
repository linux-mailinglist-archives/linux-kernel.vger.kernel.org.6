Return-Path: <linux-kernel+bounces-353447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A856992DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9B52843DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C370189F45;
	Mon,  7 Oct 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwFtpwfR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D31D5CDD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309326; cv=none; b=Gs7EK92WoEvvW+D60IAFD7yzTRcEoYlo3pQ9NjdPK4Guk467a1ou3dM+BdVjGk9pN7mTHk4pcVNmmrGEOiQxLySMUzpLi487q+5oUbytBEJnY9BPaID+9yhVGmrsVS3wHoc6ZCt0AXjM17QkdI5HDtX+3lE4o9DalsNNvPNxXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309326; c=relaxed/simple;
	bh=WkIFA3Bbn+M2B5VzgzqBsaRxhzbrBeYNIHEndslM8DI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XUcROdyXeVLGT4FhwcQn4n9s1thlveBIqXGtqCSkoK4meFevuYXVHUpXJP2i731vLVU4H192H4qxEnsC31fgXQwTHTJ1XQd+PEk0Nju4djFzQIWwabb2fothsTJg5jNRDot/xYkhqHSQIJr1GtMZhdCXiBSBT21tDB3zvwVgpkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwFtpwfR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2555d3d0eso73438317b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728309324; x=1728914124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CblMzpCPNydZZpvacmjghKpdVLiy01vOQxnw0IUvqWY=;
        b=CwFtpwfRHMfxXmO55c0Lwx/LrOjH1eknvkF7swKeU1TQfAyX0wWjit2wBTctg7Wd/w
         /qr+uqc/fYpmY2N9k90Ot6CnQaPcmAXQJPktWTiVT34PSU3QI4uZWcMrKnZnS2zTk928
         afmkzmQkDjLBHdd+ywWtMt3gX3RwgeVJcGAUA4y0aV8MNjNA0Ifq7GG8jk91dJ5KUIS/
         /hRT1pBQ+nuL5t128PBIcsgGoOnyWa98VQRvWqp4lwcCJ8fOkBU9EUmzARp+IaAS5qnS
         UEhcQpruVLvZGnMWyxZtAY8aCyxR44LOTimFhttRR9cz4HCBkiSCIr0bwwihbDdhysMc
         Q/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309324; x=1728914124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CblMzpCPNydZZpvacmjghKpdVLiy01vOQxnw0IUvqWY=;
        b=wv7SPQ70xmhMRpzq9qtNFqywVvB5SZQWIE68AjgL78sc4M+7C06ZP6QvS2LXBSfoOF
         HW40JxVbTVzdwgSTCwxMJ8x6eD/g2w+lqcZkXlZsNb0uEWzdGnVjStiU8un6Eg81xXxb
         JKGca3MIT114G/vy8F1zgffaWm40YXqFGXfjczI17Bhuukmj7riRaWJdM1ILuD67h7u+
         n7ij0plyMJryTiQJF8skCgGLwu0ioizQPSOl+gRTiipPh+UhXgsPGvjfGEy01+87Q/NZ
         lG7b9HhhHN1BeFiFLvyiJZ8mSEbYLkAs6iygRTv28n0qkCNRXC2oKGos+QO0mJJCAP+v
         zf0A==
X-Forwarded-Encrypted: i=1; AJvYcCWrIUXC3iA1DtZExRiozQwfXUiBjC03hOreU5JDmXOr5jjLoKk1LaOCQrTfytNEctIJf0UT6lJOLG0ww+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXO+lvif4S3LOoHj05vJo6VF+9Ry5ejuAGZn1C2enrcVlS1f1N
	QeieBC+nl+IVuw8KKL4NhhSTf9eY3tqmRF8k+iTRSFVQCBjCtmKyE3pR/aYod0JXCyKe+61je/Z
	gVNyrUWBzDw==
X-Google-Smtp-Source: AGHT+IHEWUgCEIy7iPCOVn7Lb+x/YbYzsOzZFkYER6vlS8wHJBCQCEMmUmC8PeUdmvbDxuhxB58u1a4APwmNFA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:690c:d1d:b0:6e2:2c72:3abb with SMTP
 id 00721157ae682-6e2c72bbd5emr3753187b3.7.1728309324364; Mon, 07 Oct 2024
 06:55:24 -0700 (PDT)
Date: Mon,  7 Oct 2024 13:55:06 +0000
In-Reply-To: <20241007135508.3143756-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241007135508.3143756-1-joychakr@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007135508.3143756-3-joychakr@google.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3: Add binding for USB Gen2 De-emphasis
From: Joy Chakraborty <joychakr@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Joy Chakraborty <joychakr@google.com>
Content-Type: text/plain; charset="UTF-8"

PIPE4 spec defines an 18bit de-emphasis setting to be passed from
controller to the PHY.
TxDeemph[17:0] is split as [5:0] C-1, [11:6] C0, [17:12] C+1 for 3 tap
filter used for USB Gen2(10GT/s).

Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 1cd0ca90127d..a1f1bbcf1467 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -190,6 +190,18 @@ properties:
       - 1 # -3.5dB de-emphasis
       - 2 # No de-emphasis
 
+  snps,tx_gen2_de_emphasis_quirk:
+    description: When set core will set Tx de-emphasis for USB Gen2
+    type: boolean
+
+  snps,tx_gen2_de_emphasis:
+    description:
+      The 18bit value of Tx deemphasis defined in PIPE4 spec driven to PHY
+      for normal operation.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 0x3ffff
+
   snps,dis_u3_susphy_quirk:
     description: When set core will disable USB3 suspend phy
     type: boolean
-- 
2.47.0.rc0.187.ge670bccf7e-goog


