Return-Path: <linux-kernel+bounces-230777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B949181CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E893E1F21B47
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7409187545;
	Wed, 26 Jun 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mtyO9Z1t"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339079F0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407158; cv=none; b=fhwI0rha4QQRxhgYNPOO3fyex5c5+4Ac1Z23R+l2NrpYy6MDkJiun8396WHHYwyz3+cllpC0vEiTVdKUgwOBKokyhr2RcodqwXLrvYj/N1gGQKc2hK/nBObsT5gJmgHdrvJlg+6wQJfHvEiibbrzyS+RRk6GT5adx/+xjXfenuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407158; c=relaxed/simple;
	bh=tYSKztlvYXjqrUVGqUlFZcjNQFbhaN4iVt2oyZFJdVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5s5IxQ6J8+769Ei8qVpKsqd3QfQb/wYhjw5bKuxOdI1+yxFxDuGoD+NkCP2nDUopaS4z/vopiErt6q9y1mfdgXMm0W7KR1OMSGAznOsM20AiipRahgsx+NuMHA59P+sYmoxLSBelPlB9h5LQi3G2ICSFpnTl8/RvbbZue9iZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mtyO9Z1t; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295e488248so7815728e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719407154; x=1720011954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=mtyO9Z1t2T1EDXVZGrkLqYk7i+oB2j+lt1paslYuCYQSOxDgHw9tyHRqJioDvVu2Gz
         WOdBvMxFFKqRUFfR16cLelrUHBo+4M+td7iSVAihK4oio/xdzUD77MLO2iH6FDxlTb26
         KkbpYcbT/swcrq7lRKtu/tvEnI02EfRAgxNVqAnGUrNxruGF+KtrfJrVZjrM2sEju08W
         gL5cEYc67ZBK4oDX8p0TsnBxSdNJkRZuq9R2sm1LOJs3UFUOyiA2a1HL//0/apUpyqiI
         6zAqFYXrgJQc4rdP+etFYDWv59wSqVm59zmpLnsMKvPUfGRfbIvjXr5+1lpwbC0eqlDC
         SO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407154; x=1720011954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6LJZCR61gmm4dvekAa0Q1TIoLF/ScrG5TtOv9gDZ/w=;
        b=fbMNkEvbUZkn+bc31qc8ddc0gmuhrLxGOwG1zUA+nEHFIy2Hh5JIKVjEldmSTEdmcG
         RZs6/SdzDWNpmD2I13/Ny/Bx+IetFvixwixASPLHZMhBCOdIfiOceaiRsIquei6ApD3p
         fgiHfhhAa3tzy9QBXow3Lt+0/b1PYa999mnMJHLmHVpzf/0I1J/onSBIVylIlrPu6yxI
         6PqKpQli1IbYz0hHyPn4Z0JyJq/XOFO3bo59URj1MNj7Cu0fPVuP8KBqV4lFx1Q8lPOv
         977dmFq0rBPGCKdo5dkKNeiV6IwLVw7cO6R4ad9kyX7IZ3ffxgvHqU9Q9CiONhd94QSw
         5o2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8L8EtaRSmw3AZvjLgbbdql62kZwUqT0L7mU+FMRYYtmGlQjgSm04+aMrJPT1D5++okWFdP+AmLS4hiiPpk52MQEiBYw6aM5NcYsCg
X-Gm-Message-State: AOJu0YzpOG5+yl5OjBZwj079avRhkHT0pmTZFegZE8iDD/K4OFtuzGaf
	H/v2juyiLMl85hgpEJaAWguX32LEDiSUemxLVaPTn6umcM9d+m0SdIpxNYM5IG8=
X-Google-Smtp-Source: AGHT+IHX+jzGQgnJriZOGQ/oAJSCUkFR6oZJI+0k3ahW32MnlEUF+2I4ESnYZpAqS9088kQ4KTVI2w==
X-Received: by 2002:ac2:5f4e:0:b0:52c:e030:144e with SMTP id 2adb3069b0e04-52ce185ecd4mr6228931e87.47.1719407154179;
        Wed, 26 Jun 2024 06:05:54 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9bd0fsm15831149f8f.52.2024.06.26.06.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:05:53 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 02/10] dt-bindings: riscv: Add Zabha ISA extension description
Date: Wed, 26 Jun 2024 15:03:39 +0200
Message-Id: <20240626130347.520750-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626130347.520750-1-alexghiti@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zabha ISA extension which was ratified in April
2024.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..e6436260bdeb 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -171,6 +171,12 @@ properties:
             memory types as ratified in the 20191213 version of the privileged
             ISA specification.
 
+        - const: zabha
+          description: |
+            The Zabha extension for Byte and Halfword Atomic Memory Operations
+            as ratified at commit 49f49c842ff9 ("Update to Rafified state") of
+            riscv-zabha.
+
         - const: zacas
           description: |
             The Zacas extension for Atomic Compare-and-Swap (CAS) instructions
-- 
2.39.2


