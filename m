Return-Path: <linux-kernel+bounces-575599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 512CAA7049F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA373ACCE4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847625B683;
	Tue, 25 Mar 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoHFEBED"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428525B681
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915367; cv=none; b=N2tbNQU71crcql/UigLKHIlnxuPX638AB51OIs0zTDUmg31Zoa3XfzPVPwn6QFK9/VqZa+kTQq9UCgKJ6kxGwW1JdHgkg3UOVGBoTpsqZleAGJWbuQb3R6oglBLgze/uYEFg7V+LIANifvrggRLaqNZ1I6gAfTG2Sje6RqOFIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915367; c=relaxed/simple;
	bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ayu6DCDxG5XK9gz3C/8TK0wu0SFgnvjvvZtsDNxyDqzViW62RcOVMIV/sgv1Xqfv707Bowncmf2VSKhfN8I/ICoxAV2ORzWr0bH71x9zm61nhoYzFG3culmwHzaRX+pgr/S8PISAHpS5r7vhliBTmwn9ri9wJSHRS24G+kh0sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PoHFEBED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742915364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
	b=PoHFEBEDhG6gg4ciCGnCJpRycz6Lz25z9M7vNMUQhNr/wZrU5YPG6BzxCBSNYHSk27KvLu
	+AJo4qp6iUBwW9d30kEXKCZpuROF2JRoao4gIDYlOjsvK3eEzZDWn+AB2pmg5DMEZIIwK9
	tqpAXEVoM9avTwIw/fVyuGdRXPheWSY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-H7MaDCaYNBmHZu6xWdjYHw-1; Tue, 25 Mar 2025 11:09:20 -0400
X-MC-Unique: H7MaDCaYNBmHZu6xWdjYHw-1
X-Mimecast-MFC-AGG-ID: H7MaDCaYNBmHZu6xWdjYHw_1742915360
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso558641766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915359; x=1743520159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
        b=Vl9ReaGzcS6aQEYZmJICjzWTwh+40VeXTrjv6MI/9wgX11QAtH+UxyLkyx/Y0Id31K
         UtDcHIva7KSfXShUojL50YAVrmvdhL/3CTu1hwRZLWff3iKIAEzK9mMghde/DGUR+3lZ
         /6GYivmW/KBaoxExFys424YS898aeoBi6szN2zVskx6aJS71xRsEaYg5ERHYIoAg1hq6
         3J6DMlrvDJEWNphoFdLyXyp4qZN5Ui/5ZX9dqURPMTdGY22E5UzzDfTsFb4HRe1k1oCm
         jruHY1eDPP0cwR/7LZHBPe1ztJ+Sc7Qjdw5Ce+MXYQeE77HsrI/LKG+/cKwIAk0P1QK1
         i0aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnMljvsARPRutdGmhwMMswAPRQCJs3jSYZQ+iWq6pW5FN46+HTGxccApgxunttdSh6plV2Runzsx1bLm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDB/atTLkzCEth3NsF8Nd9YRGRaImMf9F1uHpcWAal1IG+W6A
	00vA8uiOrMoGO0o9MPUywalNZwlK8Xn7aE+bt3SpecNXQvDFbCue6M3kefe4XeJAF4mR46+SFHX
	jDzW3AY7sh83fJ2oUkQ+fs8CicD6nQR1BcvAI4YZX+i72j21CvVyW8gN3mp2uMBarCfwnUcRrwU
	73zZdlxrEosmUL1WzDGzW+SwXyhAzPCaUVUbfT
X-Gm-Gg: ASbGnctXCEbIW3tK3utMsEtCYS9LAEPcgYbfCoDqqro3FaI5+51rkKkNDEppLDnmbXg
	sESNfSnCHBG83VUJv5CC7mlNJQOnNtnThCvF6uMqsShHFRuvIJgKRw/ERNkVIrlaCxgm6/Hct1A
	==
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id a640c23a62f3a-ac3f24d6f4cmr1790851866b.35.1742915359494;
        Tue, 25 Mar 2025 08:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOgId1LbZrltLHsKUY+negeAOdt/Yk2MPT6GyUunWZ6asILy7XQaITr0IFU8wCmrZepcUKYZwGDue8tgRpLI=
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id
 a640c23a62f3a-ac3f24d6f4cmr1790848166b.35.1742915359148; Tue, 25 Mar 2025
 08:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org> <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
In-Reply-To: <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:09:06 +0100
X-Gm-Features: AQ5f1Jrov1J0eHJ3t_FcdYu58nUqygB6AReV9HABcjx4wZEyM_z1SfPdGpJnZKI
Message-ID: <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 3. 2025 v 15:59 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
> Shouldn't the selftests always test the in-tree bpftool instead of the
> system one? Let's say there is a stray BPFTOOL environmental variable.
> In that case, the tests will give incorrect, possibly false negative
> results, if the user is expecting selftests to test what is in the
> kernel tree. If it is intended to also be able to test with another
> version of bpftool, we can work around the problem by removing the
> BPFTOOL definition from tools/scripts/Makefile.include and exporting
> it from the rtla Makefiles instead, to make sure the feature tests see
> it. The problem with that is, obviously, that future users of the
> bpftool feature check would have to do the same, or they would always
> fail, unless the user sets BPFTOOL as an environment variable
> themselves.

Or the selftests and other users could use another variable, like
BPFTOOL_TEST or BPFTOOL_INTERNAL. Not sure what you BPF folks think
about that. I believe assuming BPFTOOL refers to the system bpftool
(just like it does for all the other tools) is quite reasonable.

Tomas


