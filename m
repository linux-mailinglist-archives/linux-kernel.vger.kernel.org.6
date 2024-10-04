Return-Path: <linux-kernel+bounces-351295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22123990F64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45ED01C21878
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08AB1DD9DE;
	Fri,  4 Oct 2024 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZExCjbWp"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1F1DD9C3
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068352; cv=none; b=EuquEvK1PdxiSL75ms/CYS+7wvDRia7jICHaEDZJo7wWD7MyFLC3q1DxQvi4afOx8buTLiByHAdfBgReWbLf6gflvyaAfX9YHVxPwmlCz9bHEhDvOihkiW3SaxsSDUboAVzMQnCzJlXhTf2yqzZ7Aw3uNoVsrTFzX34l3BiWMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068352; c=relaxed/simple;
	bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYIKYMhh/RtNPaASY/uMUfNLDxm2yEyV+g2ol2lc0qgM97ddIW+i4GWMt73ab4aO+27ITnJ8TbW7B3WCHdmCNYjtCPU/6Qn1JRMWzOl0XHEqnly79A0i4UCfd4SNzfJ2hR7sddUSEJ0FYNhguFAH+6BQeJdzwIGJnNyzFIFInQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZExCjbWp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e262e36df27so2893124276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728068348; x=1728673148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
        b=ZExCjbWpU/NmNl3celrmgJSfhTD5VkDxbrXlyIYqmOAwQ/fqji4qUMD3bmG2GUTBSj
         fgWI5F0ehDiD4QcWE5K5v+FkZ0SKjZDWeizuzrm2xyzdVI5Ih/dWp9V/hpRy/BExZnZk
         j1UVVgSMcADejUhieI2/qJTJfUNQK5jZsF35gvuO+2w2pDwkK9+qZWH1JFqym8qU++sT
         V5rRFl5JMaoCh6ciVfm5YjVYvtkB0OY38HTBk9NnBGJyeXVGdf3zBCK5IA1HYy8nuhwI
         Qmct3WTrcP+V0i8a+sGgKJVlzVtswLi9Lup3QuzVdT1BU4Lw9DrcXlPGt+proDuiDZOy
         a1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068348; x=1728673148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmT6aXqXQD2xB8suxGcm1xpHdiZQm6HXjaP4ktWnw+k=;
        b=Mg2YLIYT9+BVtc+ARVAP3SRABYlg7Z6lqsL2I3m++0nymYMMfLUtrC6o8erxA2HyV9
         ZKhCBQF2YxjLzg+LphU6ld58Im+HMKYxYPIpJ7QT6lY/QHBsziEDbSewXWTyDgQTN51L
         g0Sss4iDecV9s6LhPfJY9dLSSNSBJkheRzzjqAPl0sQ7w2OFvOP9XDEoE/5NpXqmH+ba
         xpjROsaWowtfiBUfkOWb4S5FkR0MfmdWrzUJ2VPGLkzeQqIap+Ys6h5azquaMOi+RK8f
         Y5H6za0CtSMlk66biOo6p4HqDNwnBEos1pGRiHrAspFvP+fvDsN9M6hJc5KVpSquPeY7
         S0VA==
X-Forwarded-Encrypted: i=1; AJvYcCVKCb31EgKTeQaoFprPDWEOrtRStw0wrWDomCU898NBsyl7um019tlbJL+AJ6q2NY88krYmOy2gOg63fvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+M7Av516ag3QN//Rs3q8Tk4vbdM15WRsUqV+CW84qaYi1Rx91
	blQzllP7KZg+T62JlvtANE2zZqh6JxDv8G8ZjUW1UghrdGgP+xCS4Nqyr0hW9L/GT3G7ufFe2yX
	DI53WZvgIpdkYT/8AR5SHOlF6NsLEymYgKq+V
X-Google-Smtp-Source: AGHT+IG0iCzD9AFrN7PsxPgtv+RjvyOcT6RejRFpSNsBCVIrW9RtC6f8zoVh6IJM8DdDUtvP4V6iHTCxKwNS0beEFq8=
X-Received: by 2002:a5b:891:0:b0:e24:9e26:133 with SMTP id 3f1490d57ef6-e286f81947emr6696376276.14.1728068348374;
 Fri, 04 Oct 2024 11:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net> <CAHC9VhRnTrjP3kNXMmzsK4oZL7WD+uH0OuXszEPgTc5YoT5dew@mail.gmail.com>
 <CAHk-=wjLdoBcY-r64oBbKXo3hSEr5AawrP_5GSFQ4NEbCNt4Kg@mail.gmail.com>
 <20241002103830.GA22253@wind.enjellic.com> <033eb4d9-482b-4b70-a251-dc8bcc738f40@canonical.com>
 <20241004184019.GA16388@wind.enjellic.com>
In-Reply-To: <20241004184019.GA16388@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 14:58:57 -0400
Message-ID: <CAHC9VhS0aeDB2GzxJPHN8_LDk59gT_RuRKwb26K+3SzX7SQ=3g@mail.gmail.com>
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: "Dr. Greg" <greg@enjellic.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, LKML <linux-kernel@vger.kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:40=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote:
> On Wed, Oct 02, 2024 at 07:27:47PM -0700, John Johansen wrote:
> > On 10/2/24 03:38, Dr. Greg wrote:
> > >On Tue, Oct 01, 2024 at 09:36:16AM -0700, Linus Torvalds wrote:
> > >>On Tue, 1 Oct 2024 at 07:00, Paul Moore <paul@paul-moore.com> wrote:

...

> The third problem to be addressed, and you acknowledge it above, is
> that there needs to be a flexible pathway for security innovation on
> Linux that doesn't require broad based consensus and yet doesn't
> imperil the kernel.

The new LSM guidelines are documented at the URL below (and available
in the README.md file of any cloned LSM tree), the document is also
linked from the MAINTAINERS file:

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-lsm-g=
uidelines

The guidelines were developed last summer on the LSM mailing list with
input and edits from a number of LSM developers.

https://lore.kernel.org/linux-security-module/CAHC9VhRsxARUsFcJC-5zp9pX8LWb=
KQLE4vW+S6n-PMG5XJZtDA@mail.gmail.com

--=20
paul-moore.com

