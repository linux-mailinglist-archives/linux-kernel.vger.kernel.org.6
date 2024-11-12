Return-Path: <linux-kernel+bounces-406628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017419C6191
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB32C286054
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E72219E44;
	Tue, 12 Nov 2024 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KT5ndYvM"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9D218D95
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440021; cv=none; b=qlfYxJ2fad4JJ9s/B+R8GPSN1ejKnMtRqdxMhE3BYuRvdoTnVW8YRc+ys86RBq64nSb34vnEYYo9aCOUGJh4PbZPByJt5ELTynaOeMuQbBu+VL0+u8LFj5l/8o9R6kdIh/UZW+lpFzQdg/cdzFSTaQwKK6bL6boqrMbJ70mkJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440021; c=relaxed/simple;
	bh=2sRpzLseebI7Qfct9FG18ZAYBKUAoTH8qQjV2ey2nYY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BcCyYnvur2fYCaZP0OTW+X9Kw30jF5LI6S/BOl9ST0XeQjIZMQauDCIYKeLEqYZm88mJHSkYwN9jj7IuMsaVxirhgH6J+X8FLtNSXm3VMPpnGZca4AWAmyiWGc8KU6cZPEOZdwwQ9o9MpmZdZchVBZZypHWsdfLPRsDCJFAR1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KT5ndYvM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e7858820eso6816358b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440019; x=1732044819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sRpzLseebI7Qfct9FG18ZAYBKUAoTH8qQjV2ey2nYY=;
        b=KT5ndYvM0tK4jbpo32+7LAd30yA7yRYKcf7OqIDmFqIb6VopgjsVgHdl1y257mY4LM
         26fe58nne/Q4fu5iO/VRLfvkr0PGjh2YplXxP6+USFSgZupZXqsUKEQKQhvKA0ta3+y+
         Klr7srG/JHTPzA3TIPBf0KbgQWwKBc5X8IBhoLpPtqGGFKk59j3cd8gALYwAjsWrN5jQ
         hbKy2+V435XlX/boINFilNwMWjMGeuEn9k+g4YwXMSA2zaeMzt0gSaGUOf7MFA6fQZaG
         MJSLFnVAB1gq60ELtQHhPvna6DHFQmNlzi1F1rNmsv5/3oOiw2UR/80Iqxeyxh1163mZ
         bWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440019; x=1732044819;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sRpzLseebI7Qfct9FG18ZAYBKUAoTH8qQjV2ey2nYY=;
        b=b2AjnIg3oYjxa7lBcs1kzIelFwPV93WquOlsANZAEfrED3x9mWGwKQBRGZhqzNxLpi
         +Jcv6BymGUb8Rcl+V/jdl4DuileSE3tQb9Sb52VCrWAkFZzBrN44UZDAcfi4/llE/wr/
         xtXFI52EfcjQI/+klpm+tQo3ZEvDZpz/wXe9FtwaEX5X40bTGbtOc4Nr68xpr4DVZ01N
         R4JysqC1Uf6yAxlMu5CsbcwmJwdv9/JA7Hqe6LIZc3MuRYulEy1tPxAb9rEYQLCKeCt1
         Nu4jOkdqHXZDWBHwcQWpd3KSaBQqUV0qnT6ZMoSVDFskbJgwaQV81L51YwmZ4Fx4gMMY
         61Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVe1/zrpO/Yx8AYmFfy3m8DB7SYvhbWCSWE5JykS7Mn7p/S4EHPptP+7RapwOXAjdJarkF1tdV/vjDlaiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1AMQNuD6e43VGk7aQJ9XIs53/snX4/vRa3TfDObpQJnBfbkal
	Y1SPSVxk8NyFytyfl0IAVzZUdDkzeUknx7lF6vHSUPSTaDp+6/TeRBZvqt6qb1t9tl8uWnDOK9C
	4fQ==
X-Google-Smtp-Source: AGHT+IFxFnQk5O6XqppL9HFw/YCu7JzwmbeuSjSt85G05V+e4yOXzFuo9442/nAdDBu09BN7CI3n/e0nzW4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:859a:b0:71e:6122:d9c with SMTP id
 d2e1a72fcca58-72457aa8624mr14119b3a.4.1731440019072; Tue, 12 Nov 2024
 11:33:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 12 Nov 2024 11:33:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112193335.597514-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86 changes for 6.13
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

AFAIK, there are no conflicts or dependencies with other architectures or
trees.

