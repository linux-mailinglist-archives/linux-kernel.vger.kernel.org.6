Return-Path: <linux-kernel+bounces-576271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD1A70D1B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82A4188A343
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873826A089;
	Tue, 25 Mar 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAypgjk7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F19253F26
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942547; cv=none; b=S2Maq85BcE29aCCRLM5jS1qhEWGfQHpl+lurFXIS4Z3cixTtWwojWoWN1vWX6Vb5BQBGyY1PZrspHRepyi+RQ3NF/nChZsuj2Cyfzg6Hu1xqDRyf0UfKQZNYz1e6P94PLZf/TSF5raAkI7YYJtwnp5p+H6tvgSnfN7L6RYxHuhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942547; c=relaxed/simple;
	bh=y5qY7qfLM4OFU9WyeYyeqn+vrOt1cmdcoPTkNwzb2FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPWu63+shjI0bbsdRRvvo2fkDuUVpE/+YfqZq7a0Y9XtKKJrD0zydrKjodoxaYcb9lzWq2PrQGa6qxbd8ILbIU4/MuiER9lpHLmQcD4DSZul5L1O0/J+Wv5nzewJjmVQd2NT1AZYShYt7XxaTNgrtJL/3FPOafoWmz2l74veXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAypgjk7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742942544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7O59E72Eb/0/Rel9gqk13aR4t3oICTgjl1e4Apdr1I=;
	b=GAypgjk7NYqjibBa7k6cvELM1Uk/5V32laBrcZ3R0ILzMZwUE7J99xnVo7avmrgEb4QdLS
	KGq1/ZHOsYAE1WaYqQFVLj0jdeI0Pf+JwSw0r2E15Hoi+setXC1ZlvrzW4y1V8oMuLPgDq
	/bleY/1bM7CSfb3VOsikdyLF18tgBY4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-8kUaxZrTN_Ccj9xMmJ6q7A-1; Tue, 25 Mar 2025 18:42:22 -0400
X-MC-Unique: 8kUaxZrTN_Ccj9xMmJ6q7A-1
X-Mimecast-MFC-AGG-ID: 8kUaxZrTN_Ccj9xMmJ6q7A_1742942541
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30bfd03cdf6so26001681fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942541; x=1743547341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7O59E72Eb/0/Rel9gqk13aR4t3oICTgjl1e4Apdr1I=;
        b=izYzxpyqYHIqPzM+bEQSX9TXif1UqpXP+K6ZI7lZaCEKNpupU3GHkKXJ4z2pMK1pqd
         JbH/E8wirMvfXFbBljKwbT+24gBwDNidLIyjrpp4qB+utA6qyV8JI3r5PcgKpQ/Har86
         +uAfrz9BSf3DQP0tu4nA1Yeca9Dhg+c5quubysj20m3VnVu94nqe2Ns4wrYDKTADMknV
         DKmVt/AyN8hjb5nDIBDKttmU2OZrqJW4IUWPI8lvnImdZSgD6dUy6aQHf7JHC4N3qut5
         1rsA00wtK5MUZR7/BZ46LXv/LXTatNpE1rKHAEIZ2+P5Bmw5p1SIdIHU4sj7Xt2e1pjc
         NBTg==
X-Forwarded-Encrypted: i=1; AJvYcCW02u/MUvvAQzIMQNZyfzrVwexNxQs3Qu95r5CZaGyStTeLj5OYZey7jzsz97XVBz2tq3TXufNiYUfvE1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12CHukFukcIzgodjFL6FmurLhnAxdt9HJvBfg4OcSqq5KUDmQ
	WjkSgfuAMvk7tnpItG3m9PmnHL+909tTXETwFOchuJanQcAqKv5aJdHePfQkg3BRgo5nA3L66F7
	bm8wfxxrsTfjYiN6txMzUxGJzq9Zas5WcwfMR1D7l6uinaspgcXEJ3+uqEZxOSo3IJIdWYJEae6
	AUqbgNbKW/Pu7Ng5nQjuBDT3pWt9POlo7PkiSW
X-Gm-Gg: ASbGnctfb3JxjpGRiVNnfFUZ1ZdrMEfgEaDRX00YzPyFqlMR3S5Gn5GgsRsB5ENiq9p
	s/NmvILUZ0qnYNn3jqsOlKvd5H7VdsSuh4M3CdwpxFWdrU28/Rxy2ZOg1N3vVKJt9bc+7CYGXdF
	SR0SJA8AvhMn+y5belnW17v8V5AbLw4w==
X-Received: by 2002:a2e:be9f:0:b0:30b:f775:bae5 with SMTP id 38308e7fff4ca-30d7e1ffc0emr66870991fa.6.1742942541072;
        Tue, 25 Mar 2025 15:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJVIP3sINJY6Wnam6PKSRCFdcQdV9KHNYmVkZrTcQ8EWwAJCn6m2NALROqN0lO+P+RFwE5SLOa00pCEupSyeY=
X-Received: by 2002:a2e:be9f:0:b0:30b:f775:bae5 with SMTP id
 38308e7fff4ca-30d7e1ffc0emr66870871fa.6.1742942540579; Tue, 25 Mar 2025
 15:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320190514.1961144-1-mjguzik@gmail.com> <CAHk-=whd82fzhEbFRw9d_EMtR1SeefOJabjCHcm4-6jzeqqd3g@mail.gmail.com>
 <CAGudoHGNFT+LC24842ZKLWBxD3vvvddBqDKa6gkixN4Esor+RQ@mail.gmail.com>
 <CAHk-=wjo__Bj3JNw_7E8HhTDUF65LVOApvN0D2cofgotJoqpmg@mail.gmail.com>
 <CAHk-=wjxi0poUzCd666Kx5wCjgOwN5v=-zG8xSAL7Wj_ax8Zvw@mail.gmail.com> <20250321204723.1e21cb23@pumpkin>
In-Reply-To: <20250321204723.1e21cb23@pumpkin>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Tue, 25 Mar 2025 19:42:09 -0300
X-Gm-Features: AQ5f1JqVA6Sq4uPD2UJi5AqStqGaBYFIcINfDDPULRI_R0grmtQjOj7JBaA5jZI
Message-ID: <CAJmZWFHTG8cR77zrUpKF81tphcTQ1fyDO6vqnY57ptcs2yM=-A@mail.gmail.com>
Subject: Re: [PATCH] x86: handle the tail in rep_movs_alternative() with an
 overlapping store
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, x86@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, olichtne@redhat.com, 
	atomasov@redhat.com, aokuliar@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 5:47=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 20 Mar 2025 16:53:32 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Thu, 20 Mar 2025 at 14:17, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Thu, 20 Mar 2025 at 12:33, Mateusz Guzik <mjguzik@gmail.com> wrote=
:
> > > >
> > > > I have a recollection that handling the tail after rep movsq with a=
n
> > > > overlapping store was suffering a penalty big enough to warrant a
> > > > "normal" copy instead, avoiding the just written to area.
> > >
> > > Ahh. Good point. The rep movsq might indeed end up having odd effects
> > > with subsequent aliasing memory operations.
> > >
> > > Consider myself convinced.
> >
> > Actually, I think there's a solution for this.
> >
> > Do not do the last 0-7 bytes as a word that overlaps with the tail of
> > the 'rep movs'
> >
> > Do the last 8-15 bytes *non-overlapping* (well, they overlap each
> > other, but not the 'rep movs')
> >
> > Something UNTESTED like the appended, in other words. The large case
> > then ends up without any conditionals, looking something like this:
> >
> >         mov    %rcx,%rax
> >         shr    $0x3,%rcx
> >         dec    %rcx
> >         and    $0x7,%eax
> >         rep movsq %ds:(%rsi),%es:(%rdi)
> >         mov    (%rsi),%rcx
> >         mov    %rcx,(%rdi)
> >         mov    (%rsi,%rax,1),%rcx
> >         mov    %rcx,(%rdi,%rax,1)
> >         xor    %ecx,%ecx
> >         ret
>
> I think you can save the 'tail end' copying the same 8 bytes twice by doi=
ng:
>         sub     $9,%rcx
>         mov     %rcx,%rax
>         shr     $3,%rcx
>         and     $7,%rax
>         inc     %rax
> before the 'rep movsq'.

Not sure how above will work handling the remaining in %rax?

Anyway, another version may be like this to avoid
the rep movs penalty? Not sure if doing it before would be ok?

index fc9fb5d06174..a0f9655e364c 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -62,10 +62,15 @@ SYM_FUNC_START(rep_movs_alternative)
        je .Lexit
        cmp $8,%ecx
        jae .Lword
-       jmp .Lcopy_user_tail
+4:     movq -8(%rsi,%rcx),%rax
+5:     movq %rax,-8(%rdi,%rcx)
+       xorl %ecx,%ecx
+       RET

        _ASM_EXTABLE_UA( 2b, .Lcopy_user_tail)
        _ASM_EXTABLE_UA( 3b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 4b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 5b, .Lcopy_user_tail)

 .Llarge:
 0:     ALTERNATIVE "jmp .Llarge_movsq", "rep movsb", X86_FEATURE_ERMS
@@ -74,18 +79,20 @@ SYM_FUNC_START(rep_movs_alternative)
        _ASM_EXTABLE_UA( 0b, 1b)

 .Llarge_movsq:
+       /* copy tail byte first, to avoid overlapping
+          penalty with rep movsq */
+0:     movq -8(%rsi,%rcx),%rax
+1:     movq %rax,-8(%rdi,%rcx)
        movq %rcx,%rax
        shrq $3,%rcx
-       andl $7,%eax
-0:     rep movsq
-       movl %eax,%ecx
-       testl %ecx,%ecx
-       jne .Lcopy_user_tail
+2:     rep movsq
+       xorl %ecx,%ecx
        RET
-
-1:     leaq (%rax,%rcx,8),%rcx
+3:     movq %rax,%rcx
        jmp .Lcopy_user_tail

-       _ASM_EXTABLE_UA( 0b, 1b)
+       _ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
+       _ASM_EXTABLE_UA( 2b, 3b)
 SYM_FUNC_END(rep_movs_alternative)
 EXPORT_SYMBOL(rep_movs_alternative)



I have been trying to also measure the impact of changes like above, howeve=
r,
it seems I don't get improvement or it's limited due impact of
profiling, I tried
to uninline/move copy_user_generic() like this:

diff --git a/arch/x86/include/asm/uaccess_64.h
b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..2ae442c8a4b5 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -115,25 +115,8 @@ static inline bool __access_ok(const void __user
*ptr, unsigned long size)
 __must_check unsigned long
 rep_movs_alternative(void *to, const void *from, unsigned len);

-static __always_inline __must_check unsigned long
-copy_user_generic(void *to, const void *from, unsigned long len)
-{
-       stac();
-       /*
-        * If CPU has FSRM feature, use 'rep movs'.
-        * Otherwise, use rep_movs_alternative.
-        */
-       asm volatile(
-               "1:\n\t"
-               ALTERNATIVE("rep movsb",
-                           "call rep_movs_alternative",
ALT_NOT(X86_FEATURE_FSRM))
-               "2:\n"
-               _ASM_EXTABLE_UA(1b, 2b)
-               :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-               : : "memory", "rax");
-       clac();
-       return len;
-}
+__must_check unsigned long
+copy_user_generic(void *to, const void *from, unsigned long len);

 static __always_inline __must_check unsigned long
 raw_copy_from_user(void *dst, const void __user *src, unsigned long size)
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e9251b89a9e9..4585349f8f33 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -142,3 +142,24 @@ void __memcpy_flushcache(void *_dst, const void
*_src, size_t size)
 }
 EXPORT_SYMBOL_GPL(__memcpy_flushcache);
 #endif
+
+__must_check unsigned long
+copy_user_generic(void *to, const void *from, unsigned long len)
+{
+       stac();
+       /*
+        * If CPU has FSRM feature, use 'rep movs'.
+        * Otherwise, use rep_movs_alternative.
+        */
+       asm volatile(
+               "1:\n\t"
+               ALTERNATIVE("rep movsb",
+                           "call rep_movs_alternative",
ALT_NOT(X86_FEATURE_FSRM))
+               "2:\n"
+               _ASM_EXTABLE_UA(1b, 2b)
+               :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
+               : : "memory", "rax");
+       clac();
+       return len;
+}
+EXPORT_SYMBOL_GPL(copy_user_generic);


And then, using bpftrace with this script to try to measure execution times=
:

#############################
fentry:copy_user_generic
/strcontains(comm,"iperf3")/
{
        /*printf("start %ul %p\n", args.len, kptr(args.to));*/
        @start[kptr(args.to),args.len] =3D nsecs;
}

fexit:copy_user_generic
/strcontains(comm,"iperf3") && @start[kptr(args.to)-args.len,args.len]/
{
        /*printf("end %ul %p\n", args.len, kptr(args.to)-args.len);*/

        $len =3D args.len;
        $len >>=3D 1;
        $log_len =3D 0;
        while ($len) {
                $len >>=3D 1;
                $log_len++;
        }
        $log1 =3D 1;
        $log1 <<=3D $log_len;
        $log2 =3D $log1;
        $log2 <<=3D 1;
        $dalign =3D (uint64)(kptr(args.to) - args.len);
        $dalign &=3D 0x7;

        @us[$dalign,$log1,$log2] =3D hist((nsecs -
@start[kptr(args.to)-args.len,args.len]));
        delete(@start, (kptr(args.to)-args.len,args.len))
}

END
{
        clear(@start);
}
#############################

But the result is mixed at least in case of this change, I can't prove
an improvement
with it.

>
>         David
>
> >
> > with some added complexity - but not a lot - in the exception fixup cas=
es.
> >
> > This is once again intentionally whitespace-damaged, because I don't
> > want people applying this mindlessly. Somebody needs to double-check
> > my logic, and verify that this also avoids the cost from the aliasing
> > with the rep movs.
> >
> >                    Linus
> ...
>


