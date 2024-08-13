Return-Path: <linux-kernel+bounces-284709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0DC950455
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CF4287D84
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF441990A3;
	Tue, 13 Aug 2024 12:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcXSuk5T"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEA2262B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550531; cv=none; b=ZUelWkhkEc8mBLOfVqPyiaVeYOvVkw9DTG8N1p9/o0pz+kmGfJ/4oEWoPVH1CnkeA5tKas6gSj9Xwfd3QKLFmTJkEPe8ULuYFCsQ94LZKiXbAqvHVxHZKNq0L1y3yMiNxwk7IbyZru+AuiOo+H8vbDKHjH4nXYdZoIqx+vFoyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550531; c=relaxed/simple;
	bh=Wby73Vq3OBiRVl8yqphwuwU3DC7FcBH+ubVpoMR4cTo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=itNJuJy0Diz/LhG+MAvhy73YqvmwUeRPFjLzUyibxMPItkoNLC6MtDJDz29mWbRmsGbFDysl7Gl0li/hf2NrC63lN29snY/ykirl3ie9BoB/oKqixzlYqH/Ry6bO2FO5kFw7Eq3NhvnWy+IgiJt+6YfQTDMiXfjyGgndQCqJ0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcXSuk5T; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efef496ccso4463117e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550528; x=1724155328; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqfzBH4wQuhUjTGE4WPNVpsW3hnPfKmeQlc6wp4928k=;
        b=JcXSuk5T8qYRslgX/PscIWi0XBnnylkCwM8uoLxEfFG4zUbdUeKVMB9kKW+Sb1SlAd
         /sve82Hk2p/XEiWIjOYC25eHpvTD7o208LCieW1A3GW9Nufm6tcZ+f93pT84IilOgeYT
         D8LbiDwXVYNdnpPuQTULYwZCKyjvjp1B+nDLrOycpmTDvMlf5KLrq82nNco3d4DRkQw3
         uroxjJRBM0arbn0g16Ab1xD4R+tPYMo5DnI+wHuxxMk1vjlNbxb9i4d/VzX23DwyQ6eR
         rBp88OrMtm4DULfdMsClIhDkJlHu1s/UtRTy8dbjzdwiHcajLbzvxdQJmuqwngJC06IJ
         hurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550528; x=1724155328;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QqfzBH4wQuhUjTGE4WPNVpsW3hnPfKmeQlc6wp4928k=;
        b=kIg1CNNm2gWxnqQjhv1MUxkdD4QYluJGTgFi7uXJ0N4djtrjG67b7bSfrJDUZNSIfh
         k5jIitF420Aq4Y88qn0srF7M9lLILD59CJrL7cVvpcYkmbnWlpAPh5AgOufVvAvR/o47
         lmUZIpnvcf9H0qKFzkXfYbFO9AmefdOwQ9/b5WFaHMMMtkbCQhGc2kV1TcPtksCVdgfc
         9vZhCWNLOlMtTlpI6mPWZwZRR/76Kmge0406YhyyaFIB32zcCFB8VN3rJfcZNSNexw1R
         1SjEqdn5wiP5CJZpdMpiIyHPNXCxk2YuQsbOSDIvZyR1RnTpj3cm91CGjPl84ffrikOU
         FJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUEGzf1CzcjABDv19NTlqDDY1PTpsV8iFSQSlym5X6Nk54RL0qSwCRIMERqnqfBI4O9F2TeyLeH0csA4PXsIABoMEG9ej/NfZFYg0Ce
X-Gm-Message-State: AOJu0YynpH1q+MbU/GOQrt/lJ+opKwUSjPRWqULMEEA3DOljg57R2rg5
	zm8okjohhDMCLz9F/6V5SOaNyPlrz0hSOm+BVpxYb1e5RAcgRN7dvs8ynA==
X-Google-Smtp-Source: AGHT+IEAMmTgN1F5uuHRmEOHpgiza0Q2CjAzEbhYxm+oVK3Q6P41gWNLCETTiH02yFE1pV/xvDlafQ==
X-Received: by 2002:a05:6512:1293:b0:530:c1fb:5195 with SMTP id 2adb3069b0e04-53213da7285mr867692e87.18.1723550527456;
        Tue, 13 Aug 2024 05:02:07 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f42734sm969599e87.290.2024.08.13.05.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 05:02:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Wnp7LBFi9xv6Z0l0cNUjScdb"
Message-ID: <c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com>
Date: Tue, 13 Aug 2024 15:02:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] irqdomain: simplify simple and legacy domain
 creation
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com>
 <27033022-cdbe-40d9-8a97-cdc4d5c25dbe@flygoat.com>
 <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>
Content-Language: en-US, en-GB
In-Reply-To: <78fabd1a-0c68-4e23-8293-89c56eb9010b@gmail.com>

This is a multi-part message in MIME format.
--------------Wnp7LBFi9xv6Z0l0cNUjScdb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jiaxun,

On 8/13/24 13:54, Matti Vaittinen wrote:
> On 8/13/24 13:19, Jiaxun Yang wrote:
>>
>>
>> On 2024/8/8 13:34, Matti Vaittinen wrote:
>>> Move a bit more logic in the generic __irq_domain_instantiate() from the
>>> irq_domain_create_simple() and the irq_domain_create_legacy(). This does
>>> simplify the irq_domain_create_simple() and irq_domain_create_legacy().
>>> It will also ease the use of irq_domain_instantiate() instead of the
>>> irq_domain_create_simple() or irq_domain_create_legacy() by allowing the
>>> callers of irq_domain_instantiate() to omit the IRQ association and
>>> irq_desc allocation code.
>>>
>>> Reduce code duplication by introducing the hwirq_base and virq_base
>>> members in the irq_domain_info structure, creating helper function
>>> for allocating irq_descs, and moving logic from the .._legacy() and
>>> the .._simple() to the more generic irq_domain_instantiate().
>>
>> Hi all,
>>
>> This patch currently in next had caused regression on MIPS systems.

...

>> Do you have any idea on how should we fix it?

This is quick'n dirty but do you think you could try following? (I have 
only compile-tested it). I'll also attach the patch as I have no idea if 
this mail client mutilates patches. I can send in proper format if it helps.


From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Tue, 13 Aug 2024 14:34:27 +0300
Subject: [PATCH] irqdomain: Fix irq_domain_create_legacy() when 
first_irq is 0

The
70114e7f7585 ("irqdomain: Simplify simple and legacy domain creation")
changed logic of calling the irq_domain_associate_many() from the
irq_domain_create_legacy() when first_irq is set to 0. Before the change,
the irq_domain_associate_many() is unconditionally called inside the
irq_domain_create_legacy(). After the change, the call is omitted when
first_irq is set to 0. This breaks MIPS systemns where
drivers/irqchip/irq-mips-cpu.c has irq_domain_add_legacy() called with
first_irq set to 0.

Fixes: 70114e7f7585 ("irqdomain: Simplify simple and legacy domain 
creation")
Signed-off-by Matti Vaittinen <mazziesaccount@gmail.com>
---
  kernel/irq/irqdomain.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 01001eb615ec..5be165399a96 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -300,7 +300,8 @@ static void irq_domain_instantiate_descs(const 
struct irq_domain_info *info)
  }

  static struct irq_domain *__irq_domain_instantiate(const struct 
irq_domain_info *info,
-						   bool cond_alloc_descs)
+						   bool cond_alloc_descs,
+						   bool cond_force_associate)
  {
  	struct irq_domain *domain;
  	int err;
@@ -337,10 +338,9 @@ static struct irq_domain 
*__irq_domain_instantiate(const struct irq_domain_info
  		irq_domain_instantiate_descs(info);

  	/* Legacy interrupt domains have a fixed Linux interrupt number */
-	if (info->virq_base > 0) {
+	if (cond_force_associate || info->virq_base > 0)
  		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
  					  info->size - info->hwirq_base);
-	}

  	return domain;

@@ -360,7 +360,7 @@ static struct irq_domain 
*__irq_domain_instantiate(const struct irq_domain_info
   */
  struct irq_domain *irq_domain_instantiate(const struct irq_domain_info 
*info)
  {
-	return __irq_domain_instantiate(info, false);
+	return __irq_domain_instantiate(info, false, false);
  }
  EXPORT_SYMBOL_GPL(irq_domain_instantiate);

@@ -464,7 +464,7 @@ struct irq_domain *irq_domain_create_simple(struct 
fwnode_handle *fwnode,
  		.ops		= ops,
  		.host_data	= host_data,
  	};
-	struct irq_domain *domain = __irq_domain_instantiate(&info, true);
+	struct irq_domain *domain = __irq_domain_instantiate(&info, true, false);

  	return IS_ERR(domain) ? NULL : domain;
  }
@@ -513,7 +513,7 @@ struct irq_domain *irq_domain_create_legacy(struct 
fwnode_handle *fwnode,
  		.ops		= ops,
  		.host_data	= host_data,
  	};
-	struct irq_domain *domain = irq_domain_instantiate(&info);
+	struct irq_domain *domain = __irq_domain_instantiate(&info, false, true);

  	return IS_ERR(domain) ? NULL : domain;
  }
-- 
2.45.2



--------------Wnp7LBFi9xv6Z0l0cNUjScdb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-irqdomain-Fix-irq_domain_create_legacy-when-first_ir.patch"
Content-Disposition: attachment;
 filename*0="0001-irqdomain-Fix-irq_domain_create_legacy-when-first_ir.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYmQ1NzQ4ODU5MTBhNGEzYTRmZDFiZmU2MzU0MmY5NDY1YmY2ZGFkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4KRGF0ZTogVHVlLCAxMyBBdWcgMjAyNCAxNDozNDoyNyArMDMwMApTdWJq
ZWN0OiBbUEFUQ0hdIGlycWRvbWFpbjogRml4IGlycV9kb21haW5fY3JlYXRlX2xlZ2FjeSgp
IHdoZW4gZmlyc3RfaXJxIGlzIDAKClRoZQo3MDExNGU3Zjc1ODUgKCJpcnFkb21haW46IFNp
bXBsaWZ5IHNpbXBsZSBhbmQgbGVnYWN5IGRvbWFpbiBjcmVhdGlvbiIpCmNoYW5nZWQgbG9n
aWMgb2YgY2FsbGluZyB0aGUgaXJxX2RvbWFpbl9hc3NvY2lhdGVfbWFueSgpIGZyb20gdGhl
CmlycV9kb21haW5fY3JlYXRlX2xlZ2FjeSgpIHdoZW4gZmlyc3RfaXJxIGlzIHNldCB0byAw
LiBCZWZvcmUgdGhlIGNoYW5nZSwKdGhlIGlycV9kb21haW5fYXNzb2NpYXRlX21hbnkoKSBp
cyB1bmNvbmRpdGlvbmFsbHkgY2FsbGVkIGluc2lkZSB0aGUKaXJxX2RvbWFpbl9jcmVhdGVf
bGVnYWN5KCkuIEFmdGVyIHRoZSBjaGFuZ2UsIHRoZSBjYWxsIGlzIG9taXR0ZWQgd2hlbgpm
aXJzdF9pcnEgaXMgc2V0IHRvIDAuIFRoaXMgYnJlYWtzIE1JUFMgc3lzdGVtbnMgd2hlcmUK
ZHJpdmVycy9pcnFjaGlwL2lycS1taXBzLWNwdS5jIGhhcyBpcnFfZG9tYWluX2FkZF9sZWdh
Y3koKSBjYWxsZWQgd2l0aApmaXJzdF9pcnEgc2V0IHRvIDAuCgpGaXhlczogNzAxMTRlN2Y3
NTg1ICgiaXJxZG9tYWluOiBTaW1wbGlmeSBzaW1wbGUgYW5kIGxlZ2FjeSBkb21haW4gY3Jl
YXRpb24iKQpTaWduZWQtb2ZmLWJ5IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRA
Z21haWwuY29tPgotLS0KIGtlcm5lbC9pcnEvaXJxZG9tYWluLmMgfCAxMiArKysrKystLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEva2VybmVsL2lycS9pcnFkb21haW4uYyBiL2tlcm5lbC9pcnEvaXJxZG9t
YWluLmMKaW5kZXggMDEwMDFlYjYxNWVjLi41YmUxNjUzOTlhOTYgMTAwNjQ0Ci0tLSBhL2tl
cm5lbC9pcnEvaXJxZG9tYWluLmMKKysrIGIva2VybmVsL2lycS9pcnFkb21haW4uYwpAQCAt
MzAwLDcgKzMwMCw4IEBAIHN0YXRpYyB2b2lkIGlycV9kb21haW5faW5zdGFudGlhdGVfZGVz
Y3MoY29uc3Qgc3RydWN0IGlycV9kb21haW5faW5mbyAqaW5mbykKIH0KIAogc3RhdGljIHN0
cnVjdCBpcnFfZG9tYWluICpfX2lycV9kb21haW5faW5zdGFudGlhdGUoY29uc3Qgc3RydWN0
IGlycV9kb21haW5faW5mbyAqaW5mbywKLQkJCQkJCSAgIGJvb2wgY29uZF9hbGxvY19kZXNj
cykKKwkJCQkJCSAgIGJvb2wgY29uZF9hbGxvY19kZXNjcywKKwkJCQkJCSAgIGJvb2wgY29u
ZF9mb3JjZV9hc3NvY2lhdGUpCiB7CiAJc3RydWN0IGlycV9kb21haW4gKmRvbWFpbjsKIAlp
bnQgZXJyOwpAQCAtMzM3LDEwICszMzgsOSBAQCBzdGF0aWMgc3RydWN0IGlycV9kb21haW4g
Kl9faXJxX2RvbWFpbl9pbnN0YW50aWF0ZShjb25zdCBzdHJ1Y3QgaXJxX2RvbWFpbl9pbmZv
CiAJCWlycV9kb21haW5faW5zdGFudGlhdGVfZGVzY3MoaW5mbyk7CiAKIAkvKiBMZWdhY3kg
aW50ZXJydXB0IGRvbWFpbnMgaGF2ZSBhIGZpeGVkIExpbnV4IGludGVycnVwdCBudW1iZXIg
Ki8KLQlpZiAoaW5mby0+dmlycV9iYXNlID4gMCkgeworCWlmIChjb25kX2ZvcmNlX2Fzc29j
aWF0ZSB8fCBpbmZvLT52aXJxX2Jhc2UgPiAwKQogCQlpcnFfZG9tYWluX2Fzc29jaWF0ZV9t
YW55KGRvbWFpbiwgaW5mby0+dmlycV9iYXNlLCBpbmZvLT5od2lycV9iYXNlLAogCQkJCQkg
IGluZm8tPnNpemUgLSBpbmZvLT5od2lycV9iYXNlKTsKLQl9CiAKIAlyZXR1cm4gZG9tYWlu
OwogCkBAIC0zNjAsNyArMzYwLDcgQEAgc3RhdGljIHN0cnVjdCBpcnFfZG9tYWluICpfX2ly
cV9kb21haW5faW5zdGFudGlhdGUoY29uc3Qgc3RydWN0IGlycV9kb21haW5faW5mbwogICov
CiBzdHJ1Y3QgaXJxX2RvbWFpbiAqaXJxX2RvbWFpbl9pbnN0YW50aWF0ZShjb25zdCBzdHJ1
Y3QgaXJxX2RvbWFpbl9pbmZvICppbmZvKQogewotCXJldHVybiBfX2lycV9kb21haW5faW5z
dGFudGlhdGUoaW5mbywgZmFsc2UpOworCXJldHVybiBfX2lycV9kb21haW5faW5zdGFudGlh
dGUoaW5mbywgZmFsc2UsIGZhbHNlKTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGlycV9kb21h
aW5faW5zdGFudGlhdGUpOwogCkBAIC00NjQsNyArNDY0LDcgQEAgc3RydWN0IGlycV9kb21h
aW4gKmlycV9kb21haW5fY3JlYXRlX3NpbXBsZShzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndu
b2RlLAogCQkub3BzCQk9IG9wcywKIAkJLmhvc3RfZGF0YQk9IGhvc3RfZGF0YSwKIAl9Owot
CXN0cnVjdCBpcnFfZG9tYWluICpkb21haW4gPSBfX2lycV9kb21haW5faW5zdGFudGlhdGUo
JmluZm8sIHRydWUpOworCXN0cnVjdCBpcnFfZG9tYWluICpkb21haW4gPSBfX2lycV9kb21h
aW5faW5zdGFudGlhdGUoJmluZm8sIHRydWUsIGZhbHNlKTsKIAogCXJldHVybiBJU19FUlIo
ZG9tYWluKSA/IE5VTEwgOiBkb21haW47CiB9CkBAIC01MTMsNyArNTEzLDcgQEAgc3RydWN0
IGlycV9kb21haW4gKmlycV9kb21haW5fY3JlYXRlX2xlZ2FjeShzdHJ1Y3QgZndub2RlX2hh
bmRsZSAqZndub2RlLAogCQkub3BzCQk9IG9wcywKIAkJLmhvc3RfZGF0YQk9IGhvc3RfZGF0
YSwKIAl9OwotCXN0cnVjdCBpcnFfZG9tYWluICpkb21haW4gPSBpcnFfZG9tYWluX2luc3Rh
bnRpYXRlKCZpbmZvKTsKKwlzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9tYWluID0gX19pcnFfZG9t
YWluX2luc3RhbnRpYXRlKCZpbmZvLCBmYWxzZSwgdHJ1ZSk7CiAKIAlyZXR1cm4gSVNfRVJS
KGRvbWFpbikgPyBOVUxMIDogZG9tYWluOwogfQotLSAKMi40NS4yCgo=

--------------Wnp7LBFi9xv6Z0l0cNUjScdb--

