Return-Path: <linux-kernel+bounces-228080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B0915AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0015F289F53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 23:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC841BC085;
	Mon, 24 Jun 2024 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l92GOFop"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93E71A38F5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271810; cv=none; b=D8vMeWbzXNfIoXdkTFgAfgonBOt0pHiuQWEwA9wPuMJrI39runob55lMWEtj2fLwreAq39oatTXVEoOs+pvOi6ESYo5Sr4D1NXD+1PHgj0YgVuDIqY6V3OIItrzRCmYLz0EBTXuwtAH4Q8rXo40vAh5oWyIA0ckvk2w/bDg4dDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271810; c=relaxed/simple;
	bh=yboJ131KH75Qql/fVo88i+jFE+X+ykOpyD/H9YpbbNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qz7UADWxOiOXN+2i2UZ9K3Dc2KUrmVFsp31ax8kqBu9PdxN7jiX/nd8T3OnrkuDtSylAKFXePxApTHT4KohjPw8120B/pXROw3snuE2QJCr6mIWE6EWS7GdgLinr/D8lLCnTa0LrqG/mLTEnFeYBSL5wW4FuXv9VFYMgl55VTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l92GOFop; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso5433129a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719271808; x=1719876608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=l92GOFop5wbZRIETV38d3PhakKrDT3JjgloFcdfd/RlEbh30iM6+807/E+HVEStLPl
         gQzKZO+5qMQlTxd7MmHPYEXInXMiN2RGPizyNYWfz073blTGt/jO+zO2FrRy7JVuhmEo
         sypzCoaJcyxe/H4kPJ/mk915ewHHCYDHajzhZvLEs2udjA+pnX/uDlzSmWdbD1hQB2hy
         lmElSLDbkKIZYuruwCSNdzI/Gfb+XPDj8Rojg4tBkbLmySznMSUufNh0j597Qfi/wXFZ
         cwS9jvCey6+B4I19SC4ZqLS/wUqs2V7ahEkdwA0SRp9zfYI6y/sxVAyNMGvZz5PEVhl7
         ne6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719271808; x=1719876608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmF+q3rwrhR8UU+6OXTpwv5GaDaD/Y47DiJtkxDn41A=;
        b=sD7NwTExLMe+Z15Yx1WYnV5P9VZlqL7lCDuJlh8kWe8kP4mMBidiMYJ7xJbeavkJ6u
         Z1Yqu1ujIFjBCXsiSn21+m2d2ShXkBa/RvWXikOY2qGf59RkPPHnbfNixbwCu4U/6Ju4
         XHHl7o9v4qOlSqAKVXwJoYIADZhmG2To7LlDQbs6AsKpdzlPVwx1YxpXld3do8O52zFS
         aaorvez7A/QNSwFbvmg58zrGBPBSleiy2j4EO6+EA7ssJ7h7zZkaUUHJapZ/HXnJqLYH
         GnPbKmY6fuMJ9ATZp8MZv92W/z5M47rfnZcmMglr+sjRvr9kWgzNQix1qlpIiPrk177w
         2i4g==
X-Gm-Message-State: AOJu0Yw/7pAkFN38IHBtwvN1bxxBqFO3fXklB1B83S0YZGG3gQhIFrOU
	fnMOTjKK1xjNaGz0frN54c64NWlAEFO5M/RT8c6QPo6UY2bcn/R4E+ZCIPp/v91fcqmOzxM4fFn
	KUQ==
X-Google-Smtp-Source: AGHT+IHcaOj/Ro9h0704QE00MFW9hpEi3kDY+mehE3/RAXufwF49RwalyubuviiuKxGcrX2qWa70mRNXqFw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:9d83:0:b0:6e9:8a61:b8aa with SMTP id
 41be03b00d2f7-71ac38a3772mr20790a12.0.1719271808040; Mon, 24 Jun 2024
 16:30:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 23:26:22 +0000
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624232718.1154427-14-edliaw@google.com>
Subject: [PATCH v6 13/13] selftests/sgx: Append CFLAGS from lib.mk to HOST_CFLAGS
From: Edward Liaw <edliaw@google.com>
To: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com, seanjc@google.com, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, 
	iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sgx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

lib.mk CFLAGS provides -D_GNU_SOURCE= which is needed to compile the
host files.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 867f88ce2570..03b5e13b872b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,7 +12,7 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC $(CFLAGS)
 HOST_LDFLAGS := -z noexecstack -lcrypto
 ENCL_CFLAGS += -Wall -Werror -static-pie -nostdlib -ffreestanding -fPIE \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
-- 
2.45.2.741.gdbec12cfda-goog


