Return-Path: <linux-kernel+bounces-553193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002BA5855B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62541887174
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD11EB5EF;
	Sun,  9 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1u/Mnxo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B01DF24A;
	Sun,  9 Mar 2025 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533801; cv=none; b=h9a13UDgqbwKPyZr6BGce4OShEOx7dvZROcTpxFC9ihpN+AVmw257OxAOqyF6jE5sdBuD+lMYF1CTGmbroazULfD5TvBka4W3LkwgidIueb1lSNBBDXNQ3dkS79qCUO4cDD1WDPgPdxtoyzWgAnjWcfdvQR7ioJVKJnsFC1ryYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533801; c=relaxed/simple;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BXihp/x9iBPvwagCCb780Tc/ruUDeCqtvjLfMvDjFNA7gjh4+I+ne4phMiSNCkoWRlNVSYFp/isFHuTnO71EQJg+MAeNXMVl+p057G67MhhevuhFhuiVCUPlBLrPtfYfCxlLLeKiS8nx43Lu9hK2ipS9cXBsMeEuUd0t91zF7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1u/Mnxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA7C4CEE3;
	Sun,  9 Mar 2025 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533801;
	bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E1u/MnxoXx1A7LDzg0kPddqiAowRHyGn/RdL8JrL/U98+OC0OMh19kZJPwigs28lw
	 GuNYucLMOBZTQZdbyL+q2UWYxY9N57V3CZ3/uWyQmVI0ifRAL12MiNcaoofJT1IAPd
	 eECeyTnyCJrd+vlyNPjj4QF5rA8Z31+1z2rwiKw6Hz8haaRFpLYKz4TM3kR81jgLLl
	 M1F1xQLYw+fYOzllKZz84fGTh3Xojvx9zxQt9fhjrxWAS/j9dydu+gwroDBLA1qycd
	 +HVocNgemfHuMLCe0d8vEpZ/I/Uqww9H8oDo4oNu9as8y4AH4GgUoh07L1nhp3Fq2t
	 M/HVBQk9T/HWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:19:00 +0100
Subject: [PATCH v12 09/13] rust: alloc: add `Box::into_pin`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-9-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Wo/kUAupEBOIsOdnruISz8EyJEcYwqNCGfSTf35FejE=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFvMqC0QKWGh83nKT2AC3rlw7wZqeANJ3wNn
 V/HPDO0f52JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xbwAKCRDhuBo+eShj
 d0PGD/9zIwXJPnYU1QuDIUlbYFsznGHG12KC+Xa/JFJ+z7E+4zDRc4B+aoMRo348dOx/GJfWgVW
 y0FsBRIn1uT0RoDdqr0sXvRF/2aV82hLZb8do7GRaJ7xvOeEmtnLqsJf1eMPfjmE3//bwuTrcF3
 lv3TESLYJm1YGhaic5VWQhXaCZma1ZBaL9QvSqKRUurQ1ZtTs2nlqyz06S6U34TwYiKNe9xu0vP
 YkE4hiAjExfGoK8hTKNjp6cZJaw4+5VkSY325FTy3SaBR84cXYybj/WEsg5JZKIF8W5sXyXDSwm
 Iy1pVF6+7tpu5ZRKQTuCWjBeRd2pBEBvvchWL8YcUQvnxKhtCn1eejb1su0u7+ptBs7DBu/4dh/
 QHgLfh7iQ9itXdS6hkEyE3EAO99LYbA0/nCDEFmyx8zSC7szB2bPPI8YIjikfZ2yuKrt3YwzMPz
 rl9CAzEl93XEmndCJoABr1WLamm1nAANlB2IKEi+Njz5ppExS4rXaUaIdkG7ZSOG5ESDXI7qydA
 esyGPcjTV6O0Fci/TUJoq+Pcm8Yjg1D/Eb874Vioa0jEokeTUlST2YmyH/WrZ8eh0rBCHfR6OA0
 kvVb0hdxC1WyiS1GK3meVpaPwWO0qNfaiEmrKEa+zXy6W9m1JghvH31uVP5SdE5wAl4XS0Uc4uv
 uFq7dnanJOa68kg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add an associated function to convert a `Box<T>` into a `Pin<Box<T>>`.

Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index cb4ebea3b074..9da4a32e60bc 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -245,6 +245,12 @@ pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
         Ok(Self::new(x, flags)?.into())
     }
 
+    /// Convert a [`Box<T,A>`] to a [`Pin<Box<T,A>>`]. If `T` does not implement
+    /// [`Unpin`], then `x` will be pinned in memory and can't be moved.
+    pub fn into_pin(this: Self) -> Pin<Self> {
+        this.into()
+    }
+
     /// Forgets the contents (does not run the destructor), but keeps the allocation.
     fn forget_contents(this: Self) -> Box<MaybeUninit<T>, A> {
         let ptr = Self::into_raw(this);

-- 
2.47.0



