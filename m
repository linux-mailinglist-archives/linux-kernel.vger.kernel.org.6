Return-Path: <linux-kernel+bounces-391209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320559B83D7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F4A1F217FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998E1CF7D8;
	Thu, 31 Oct 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEP9wUf8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F091CF5D9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404596; cv=none; b=t9nGgPS5L9pTYfSXZp4n4r4OQUbfVH0gHCE0ahZGLinhyTSjQQ0QStoP990J760765UypW4NeDWA8kTNg8kA+ms6lNXNm61lrmCQ9RByT+jXjJvysyG0cfgvLcgUG7HFUR1Unq3yCPwS2vvFHf5q8DgfAXoxKoeRNaPFzgpmxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404596; c=relaxed/simple;
	bh=scF15DBRDvh6LFM+yJGz6csw0YC4b82QxVRvUgcjjIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tuBf3kjMfCS/UnSSl8+5rIr1BJ0ZRsXTbQVptaYiCvmpAVrdCrNmvXTVD45fCE6lHkFEjBc7UWUUbj5ct5W30sf5335+0Kn/snjaTHnXnylQlrqyT41MA3cf3Ewmr0VrwEXveoMlR4OSE1zdsho/rL2BllHjikwp1IN8UF3UVqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEP9wUf8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e30cf48435fso2560973276.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404593; x=1731009393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBNJUwhGy6IFJuYLeumtEE8caNJWotKSkO0EVZhaWc=;
        b=FEP9wUf8hnslC1NQFqAn9PxqzIrt8XTcRXc1CctzgifHR6xsfZ7Tw6bfHpZtOXZDoK
         mLH3Hoat99LsGt+sLhjvyh4XgfhVffNnfv0HWtqX3L2LcvKuGSl8byIMM1MEt/uQcTAk
         ltjm4/JD0dwDBlm83a3a5FPRDLr3blWvgkdMmtH6c7l5pHmtWz2uxEGFNDJo/fKznQrM
         ZhzQ6NKXCuhgXfu2aVMDgSUXcAh1duO2vC6EdZApAzbPjkhi6EWNGIxZIzMN55Go/g/a
         jHySlMve48YhzpuVG4Yq0vnI5aQELPaDKwkm4CXGhE9fCsHVK9TnYuWtxOCY5CAh1wNW
         Oz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404593; x=1731009393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJBNJUwhGy6IFJuYLeumtEE8caNJWotKSkO0EVZhaWc=;
        b=RHteucwN+7y5PAJ+PaN2voRoo17+/nsgY5zJN9KFv2N9LLYivAEteK+Ldif4M7WIST
         RfZzXiMt7TMAqOlU0ws/apzLsjzWqJJBEqZG2RZ7esY6lUQoLmBF8xN01/KFb6Eiqn8w
         sDfnCInoBIqmSRcZduB8IOsVuET+8JvKE0XmBcFZJ8zQ8AkEs7fqUmHjZYA2wsMnH7EN
         1Qd+vk6QS9oeJIn9+X8uisdhdvk4UQEtzRbr5SnwFg+49Y8tDvv2L2L21iumoZDQvQld
         w+CeWgXI09O1atKkx4lThO4yNGY1WYBz77gQF6viY+ebJsVJHzIQp/XudgqAK+PKEs4W
         1ueg==
X-Forwarded-Encrypted: i=1; AJvYcCXO06GpKVUVug1k4pk/ryz8fi5XgV/Nx3XH62GnlOt0TccERaOVcLPZSfZk7MrJKBvDFwiHvg737ZS7txw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhmGw4k+U++blvkuGivyqVMAAEFciRRYrq3G3+1gwHlq9RBwe0
	72U9v0D9WaJbM1RJDzMjrHBmHU/xwwA9cMdL1HjRY8P9UjO07ACNx+L5Ey6QQK0oq2vHNK2SeLh
	fPQ==
X-Google-Smtp-Source: AGHT+IF5mY8H8HWNIZUe92ntcTAhodfObTAzfmyjPW6IHcMnBhuTa1ixQoAbbew71W7KOu+g/mzrj4F22KI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:b28c:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e30cf49bcc3mr5142276.6.1730404593224; Thu, 31 Oct 2024 12:56:33
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:52 -0700
In-Reply-To: <20240913054315.130832-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240913054315.130832-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039503050.1508303.8326452918836844664.b4-ty@google.com>
Subject: Re: [PATCH -next] KVM: selftests: Use ARRAY_SIZE for array length
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Sep 2024 13:43:15 +0800, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/testing/selftests/kvm/x86_64/debug_regs.c:169:32-33: WARNING: Use ARRAY_SIZE.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Use ARRAY_SIZE for array length
      https://github.com/kvm-x86/linux/commit/f8912210eb21

--
https://github.com/kvm-x86/linux/tree/next

