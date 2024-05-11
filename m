Return-Path: <linux-kernel+bounces-176690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F58C335B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0992B1C20D73
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954551CA9E;
	Sat, 11 May 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3h/p2T6"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19D366;
	Sat, 11 May 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715454423; cv=none; b=Tw/ugTKcJa22s3NLyLHjAk+rTzLdXZvVHF7dfti1Ukr/AMKJ/XG5nI7DzqmCUfiGISTe7Bg7F3FoI5tL1b8bnvwlznBEb2iGKs7zn/kXMqMhnyQasDkc7nqIEMMDddxhELzz4/+p1tUjMFHvVw1/e1w/XsLYlj6C1oMiNmeo5Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715454423; c=relaxed/simple;
	bh=hHRqAUoBRH82pJuymk4l5g2SstMzMc4ea1ZkfNBzjC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PN+m0O2aeolQokhjeKXPJzWhKjWxS62c0A29GMkDX1J8S/INRjl26vUUGucegBYKthw6ZbaTYMZ1Tt5W3YFhbatym0Z5QMMupQa5HNrz2aekGNIGN8jAd+byQHzmYIkzUvAxZD0GG8JYMQZjP5ydw2JgmOsPM3Ebc3VdhgEXf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3h/p2T6; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6f44881ad9eso2603267b3a.3;
        Sat, 11 May 2024 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715454421; x=1716059221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKFpB0RxiHeU9h9LrzBPuEHdR23O3Fp1vgl2G/bmm/Y=;
        b=j3h/p2T6IKUYLsCGEaV8qo44dgPmQxiD7RykXf0EWABlWpYDuSXISSdQktvxUNJSJ4
         qWOrUsuRF6uYWBszLiMBjEb9ldNHM9OlJbqSerKp0jibE/vpuOPV5U6dO/X3xYHMz0Zx
         D+6fpNqufz51b6cfA1WSR83uNsSH0cWAx6L8Tpm4OQrcn1CLuoNyob0GPxFA24JVC8ZC
         E+XNCvWqxFF3Chdv1Xjs4wabgn7v85MA+Qc5bQTW4J9HfUaotd4oI1xHlbZFEKrQzZJs
         +12S9hZRH6CZ5MPLAW5obggGRZbmkHPXFS1LKwHRUyeV4iL6sIMqhakrYRpOEs7NDxnL
         Oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715454421; x=1716059221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKFpB0RxiHeU9h9LrzBPuEHdR23O3Fp1vgl2G/bmm/Y=;
        b=AeoM6HKxBawhGL5Pj1pgQCnMBZEK0A12g/2MXmmtP9yp3blAfKGOKpzKzyZHb4DtST
         W+fFu/RIctEPaG7J9SgwF/ysBg7IArjpKW2DjEpmUts8FZURkqTXf+9h5+y/Vldjpli0
         mTvMEzT3bPxA/0yTl/T2RUe6u/Vq9XtdwsbAZ8BdIQcmQ9eKiCm2g7H1LEZv/kNmm30n
         SnQG6o+x5wWTWE0UbnPY15THpTxjBPDhJ7PvFipD0HF6+4+SO540YmZ98Q8Ic26UU4Hi
         V0JFFJz2GmXmmLuPSdRsqLNBwF9GYHJhE/RzYLFIjmrl9qhe02ToPVkmQTkw/PWp/uao
         p/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXRNlu0sHLqzRk8qqojEX0pK/YwmF/B06XwjmsuBlBJAeITOtrYhF46CqYy1MuKJdnUMFvp24Lh1BKTyQGoamG/mV10VImyYvP66B5uywI2+bop8Nlujuc0BLWHSZY+M63pq/cVZ81Q260tz9zkw6bLMF1eUIPewEAIbpG15a3F76wM
X-Gm-Message-State: AOJu0YxPeigPN39aA9wlGFsc2RNRi4u1e1A4pMn9lWEJ0B3a0bXsx/aB
	WotWvSsX7QFf7K2JEeak23gtI3wixp/8+o0kRlnfACJbJWch4NTg
X-Google-Smtp-Source: AGHT+IGmo2f78jWcqywMtYZHpVsGSJ2APhbQt+bMScxXaLDUI2+mPESa9uh0vzNCj3GOlsrEu3zlxg==
X-Received: by 2002:a05:6a21:2709:b0:1af:d240:2c14 with SMTP id adf61e73a8af0-1afde0a9c02mr6414939637.6.1715454421184;
        Sat, 11 May 2024 12:07:01 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a22dsm7093588a91.3.2024.05.11.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 12:07:00 -0700 (PDT)
From: yskelg@gmail.com
To: Jonathan Corbet <corbet@lwn.net>
Cc: Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] Documentation: security-bugs Korean translation
Date: Sun, 12 May 2024 04:06:40 +0900
Message-Id: <20240511190639.20235-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This is a Documentation/process/security-bugs korean version.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 .../ko_KR/process/security-bugs.rst           | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/translations/ko_KR/process/security-bugs.rst

diff --git a/Documentation/translations/ko_KR/process/security-bugs.rst b/Documentation/translations/ko_KR/process/security-bugs.rst
new file mode 100644
index 000000000000..b8f16fe846ac
--- /dev/null
+++ b/Documentation/translations/ko_KR/process/security-bugs.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+:Original: Documentation/process/security-bugs.rst
+:Translator: Yunseong Kim <yskelg@gmail.com>
+
+보안 버그
+=========
+
+Linux 커널 개발자는 보안을 매우 중요하게 생각합니다.
+따라서 보안 버그를 발견하면 가능한 한 빨리 수정하고 공개할 수 있도록
+알려주시기 바랍니다. 보안 버그를 Linux 커널 보안 팀에 신고해 주세요.
+
+제보하기
+--------
+
+Linux 커널 보안팀은 <security@kernel.org> 이메일로 연락할 수 있습니다.
+버그 신고를 확인하고 수정 사항을 개발 및 릴리스하는 데 도움을 줄 보안 담당자의
+비공개 목록입니다. 이미 수정 사항이 있는 경우 신고에 포함하면 처리 속도가
+상당히 빨라질 수 있습니다. 보안팀이 보안 취약점을 파악하고 수정하기 위해
+영역 관리자의 도움을 추가로 받을 수도 있습니다.
+
+모든 버그가 그렇듯이 더 많은 정보를 제공할수록 진단과 수정이 더 쉬워집니다.
+어떤 정보가 도움이 될지 잘 모르겠다면
+'Documentation/admin-guide/reporting-issues.rst'에
+나와있는 문제 신고하기 절차를 검토해 주세요. 모든 보안 취약점 공격 코드는
+매우 유용하며 이미 공개되어 있지 않은 한 신고자의 동의 없이 공개되지 않습니다.
+
+가능한 경우 첨부 파일 없이 일반 텍스트 이메일을 보내주세요.
+첨부 파일에 모든 세부 사항이 숨겨져 있으면 복잡한 문제에 대해 맥락에 맞는
+토론을 하기가 훨씬 더 어렵습니다. (아직 패치가 없는 경우라도) :doc:`일반적인
+패치 제출<../../../process/submitting-patches>`과 마찬가지로 문제와 영향을
+설명하고, 재현 단계를 나열하고, 제안된 수정 사항을 모두 일반 텍스트로
+작성하세요.
+
+공개 및 엠바고 정보
+-------------------
+
+보안 목록은 공개 채널이 아닙니다. 이에 대해서는 아래의 조정 사항을 참조하세요.
+강력한 수정이 개발되면 릴리스 프로세스가 시작됩니다. 공개적으로 알려진 버그에
+대한 수정 사항은 즉시 릴리스됩니다.
+
+공개적으로 알려지지 않은 버그에 대한 수정 사항이 제공되는 즉시 공개하는 것을
+선호하지만, 신고자 또는 영향을 받는 당사자의 요청에 따라 공개 프로세스
+시작일로부터 최대 7일 동안 연기될 수 있으며, 버그의 중요도에 따라 시간이 더
+필요하다는 데 동의하는 경우 예외적으로 14일까지 연장될 수 있습니다.
+수정 사항 공개를 연기할 수 있는 유일한 유효한 이유는 릴리스 조율이 필요한 QA
+및 대규모 롤아웃의 복잡한 실행 계획을 수용하기 위해서입니다.
+
+엠바고된 정보는 수정 개발을 위해 신뢰할 수 있는 개인과 공유할 수 있지만,
+신고자의 허가 없이 수정 사항과 함께 또는 다른 공개 채널에 게시할 수 없습니다.
+여기에는 원래의 버그 보고서와 후속 논의(있는 경우), 보안 취약점 공격 코드,
+CVE 정보 또는 신고자의 신원이 포함되지만 이에 국한되지 않습니다.
+
+다시 말해, 저희의 유일한 관심사는 버그 수정입니다. 보안 목록에 제출된 기타
+모든 정보와 보고에 대한 후속 논의는 엠바고가 해제된 후에도 영구적으로 기밀로
+취급됩니다.
+
+다른 그룹과의 협력
+------------------
+
+커널 보안팀은 버그 수정에만 집중하는 반면, 다른 그룹은 배포판의 문제를
+해결하고 운영 체제 공급업체 간의 공개를 조율하는 데 중점을 둡니다.
+조율은 일반적으로 "리눅스 배포판" 메일링 리스트에서 처리하고 공개는
+공공의 "oss-security" 메일링 리스트에서 처리하며, 이 둘은 서로 밀접하게
+관련되어 있으며 리눅스 배포판 위키에 제시되어 있습니다:
+<https://oss-security.openwall.org/wiki/mailing-lists/distros>
+
+세 가지 목록들이 추구하는 목표가 다르기 때문에 각각의 정책과 규칙이 다르다는
+점에 유의하세요. 커널 보안 팀과 다른 팀 간의 조율이 어려운 이유는
+커널 보안 팀의 경우 간혹 엠바고(최대 허용 일수에 따라)는 수정이 가능한
+시점부터 시작하지만, "리눅스 배포판"의 경우 수정 가능 여부와 관계없이 초기
+게시물부터 목록에 올라오기 때문입니다.
+
+따라서 커널 보안팀은 잠재적인 보안 문제를 신고하는 경우 해당 코드의
+메인테이너가 수정 사항을 수락하고 위의 배포판 위키 페이지를 읽었으며
+"리눅스 배포판" 메일링 리스트에 연락하는 것이 자신과 커널 커뮤니티에 부과되는
+요구 사항임을 완벽히 이해할 때까지 "리눅스 배포판"에 연락하지 않을 것을
+강력히 권장합니다. 이는 또한 일반적으로 수락된 수정 사항이 아직 병합되지 않은
+상태에서 조정을 위한 경우를 제외하고는 두 목록을 한 번에 참조하는 것이
+합리적이지 않다는 것을 의미합니다. 즉, 수정 사항이 수락될 때까지는
+"리눅스 배포판"을 메일에 참조하지 말고, 병합된 후에는 커널 보안 팀을 메일에
+참조하지 마세요.
+
+CVE 할당
+--------
+
+보안팀은 불필요하게 프로세스를 복잡하게 만들고 버그 처리를 지연시킬 수
+있으므로 보고나 수정에 대해 CVE를 할당하지 않으며, 이를 요구하지도 않습니다.
+보고자가 확인된 문제에 대해 CVE 식별자를 할당받고자 하는 경우 :doc:`커널 CVE
+할당팀<../../../process/cve>`에 연락하여 할당받을 수 있습니다.
+
+비공개 계약서
+-------------
+
+Linux 커널 보안 팀은 공식적인 기관이 아니므로 기밀 유지 계약을 체결할 수
+없습니다.
-- 
2.34.1


